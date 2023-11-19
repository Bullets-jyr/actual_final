import 'package:actual_final/common/model/cursor_pagination_model.dart';
import 'package:actual_final/common/model/model_with_id.dart';
import 'package:actual_final/common/model/pagination_params.dart';
import 'package:actual_final/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _PaginationInfo {
  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;

  _PaginationInfo({
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefetch = false,
  });
}

class PaginationProvider<T extends IModelWithId, U extends IBasePaginationRepository<T>> extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,

    // 지금 현재 데이터가 있는 상태인데 거기에다가 마지막 값에 추가를 해가지고 데이터를 더 가져와라
    // 추가로 데이터 더 가져오기
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태를 덮어씌움), 데이터를 유지한 상태에서 새로고침 즉, 화면에 기존 데이터가 보이는 상태에서 새로고침
    bool fetchMore = false,

    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading(), 화면에 있는 데이터를 다 지워버리고, 아에 가운데다가 로딩 인디케이터를 보여줌
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지 가능성
      // State의 상태
      // [상태가]
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음), forceRefetch가 true인 경우에 해당
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
      // 5) CursorPaginationFetchingMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

      // 바로 반환(return)하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면) paginate함수를 실행할 필요가 없음
      // 2) 로딩중 - fetchMore(앱에서 맨 아래까지 스크롤을 다 가가지고 더 데이터를 추가로 가져와라 하는 상황) : true, 데이터가 아직 들어오기 전에 만약에 우리가 똑같은 요청을 넣게 된다면 또 똑같은 데이터를 또 불러오게 됨
      //    로딩중인데 바로 반환(return)을 안해주는 상황? fetchMore가 false일 때! 새로고침의 의도가 있을 수 있다. 기존 요청이 중요하지 않기 때문에 그냥 paginate를 실행합니다.
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        // 데이터를 가져온 적이 있어야 판단이 가능함!
        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      // 2번 반환 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 Fetch (API 요청)를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
        }
        // 나머지 상황 (데이터를 유지할 필요가 없는 상황)
        else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        // 기존 데이터에
        // 새로운 데이터 추가
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
