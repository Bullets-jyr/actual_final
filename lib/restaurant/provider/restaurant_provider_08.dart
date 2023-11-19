import 'package:actual_final/restaurant/model/restaurant_model.dart';
import 'package:actual_final/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider08 = StateNotifierProvider<RestaurantStateNotifier08, List<RestaurantModel>>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);

  final notifier = RestaurantStateNotifier08(repository: repository);

  return notifier;
});

class RestaurantStateNotifier08 extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;

  RestaurantStateNotifier08({
    required this.repository,
  }) : super([]) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();

    state = resp.data;
  }
}
