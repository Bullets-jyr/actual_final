import 'package:actual_final/common/const/data.dart';
import 'package:actual_final/common/dio/dio.dart';
import 'package:actual_final/common/model/cursor_pagination_model.dart';
import 'package:actual_final/common/model/pagination_params.dart';
import 'package:actual_final/common/repository/base_pagination_repository.dart';
import 'package:actual_final/product/model/product_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
    final dio = ref.watch(dioProvider);

    return ProductRepository(dio, baseUrl: 'http://$ip/product');
  },
);

// http://$ip/product
@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
