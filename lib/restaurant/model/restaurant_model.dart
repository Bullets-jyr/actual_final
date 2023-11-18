import 'package:actual_final/common/const/data.dart';
import 'package:actual_final/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

// flutter pub run build_runner build
// flutter pub run build_runner watch
@JsonSerializable()
class RestaurantModel {
  // {
  //   "id": "5ac83bfb-f2b5-55f4-be3c-564be3f01a5b",
  //   "name": "불타는 떡볶이",
  //   "thumbUrl": "/img/떡볶이/떡볶이.jpg",
  //   "tags": [
  //   "떡볶이",
  //   "치즈",
  //   "매운맛"
  //   ],
  //   "priceRange": "medium",
  //   "ratings": 4.52,
  //   "ratingsCount": 100,
  //   "deliveryTime": 15,
  //   "deliveryFee": 2000
  // },

  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json)
  => _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //           (e) => e.name == json['priceRange'],
  //     ),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}