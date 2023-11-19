import 'package:actual_final/common/model/cursor_pagination_model.dart';
import 'package:actual_final/common/provider/pagination_provider.dart';
import 'package:actual_final/rating/model/rating_model.dart';
import 'package:actual_final/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider.family<RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));

  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier extends PaginationProvider<RatingModel, RestaurantRatingRepository> {

  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
