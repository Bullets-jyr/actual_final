import 'package:actual_final/common/const/data.dart';
import 'package:actual_final/restaurant/component/restaurant_card.dart';
import 'package:actual_final/restaurant/model/restaurant_model.dart';
import 'package:actual_final/restaurant/model/restaurant_model_03.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RestaurantScreen03 extends StatelessWidget {
  const RestaurantScreen03({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final storage = FlutterSecureStorage();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              print(snapshot.error);
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel03.fromJson(
                    json: item,
                  );

                  return RestaurantCard(
                    image: Image.network(
                      pItem.thumbUrl,
                      fit: BoxFit.cover,
                    ),
                    // image: Image.asset(
                    //   'asset/img/food/ddeok_bok_gi.jpg',
                    //   fit: BoxFit.cover,
                    // ),
                    name: pItem.name,
                    // type 'List<dynamic>' is not a subtype of type 'List<String>'
                    // tags: item['tags'],
                    tags: pItem.tags,
                    ratingsCount: pItem.ratingsCount,
                    deliveryTime: pItem.deliveryTime,
                    deliveryFee: pItem.deliveryFee,
                    ratings: pItem.ratings,
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
