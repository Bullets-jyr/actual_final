import 'package:actual_final/common/model/cursor_pagination_model.dart';
import 'package:actual_final/common/utils/pagination_utils.dart';
import 'package:actual_final/restaurant/component/restaurant_card.dart';
import 'package:actual_final/restaurant/model/restaurant_model.dart';
import 'package:actual_final/restaurant/provider/restaurant_provider.dart';
import 'package:actual_final/restaurant/repository/restaurant_repository.dart';
import 'package:actual_final/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen11 extends ConsumerStatefulWidget {
  const RestaurantScreen11({super.key});

  @override
  ConsumerState<RestaurantScreen11> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen11> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantProvider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 완전 처음 로딩일때
    if (data is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore extends CursorPagination
    // CursorPaginationRefetching extends CursorPagination
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                child: data is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터입니다 ㅠㅠ'),
              ),
            );
          }

          final pItem = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: pItem.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16.0);
        },
      ),
    );
  }
}
