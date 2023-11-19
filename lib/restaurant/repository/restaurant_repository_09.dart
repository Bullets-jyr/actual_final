import 'package:actual_final/common/const/data.dart';
import 'package:actual_final/common/dio/dio.dart';
import 'package:actual_final/common/model/cursor_pagination_model.dart';
import 'package:actual_final/common/model/pagination_params.dart';
import 'package:actual_final/restaurant/model/restaurant_detail_model.dart';
import 'package:actual_final/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository_09.g.dart';

final restaurantRepository09Provider = Provider<RestaurantRepository09>((ref) {
    final dio = ref.watch(dioProvider);

    final repository = RestaurantRepository09(dio, baseUrl: 'http://$ip/restaurant');

    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository09 {
  // http://$ip/restaurant
  factory RestaurantRepository09(Dio dio, {String baseUrl}) =
      _RestaurantRepository09;

  // http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
