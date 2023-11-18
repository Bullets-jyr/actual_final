import 'package:actual_final/common/const/data.dart';
import 'package:actual_final/common/dio/dio.dart';
import 'package:actual_final/restaurant/component/restaurant_card.dart';
import 'package:actual_final/restaurant/model/restaurant_model.dart';
import 'package:actual_final/restaurant/repository/restaurant_repository.dart';
import 'package:actual_final/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen06 extends StatelessWidget {
  const RestaurantScreen06({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(
        storage: storage,
      ),
    );

    final resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              print(snapshot.error);
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index];

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
              );
            },
          ),
        ),
      ),
    );
  }
}
