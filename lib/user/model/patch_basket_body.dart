import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

/*
* {
*   "basket": [
*     {
*       PatchBasketBodyBasket
*     }
*   ]
* }
* */

@JsonSerializable()
class PatchBasketBody {
  final List<PatchBasketBodyBasket> basket;
  // final String productId;
  // final int count;

  PatchBasketBody({
    required this.basket,
    // required this.productId,
    // required this.count,
  });

  Map<String, dynamic> toJson() => _$PatchBasketBodyToJson(this);
}

@JsonSerializable()
class PatchBasketBodyBasket {
  final String productId;
  final int count;

  PatchBasketBodyBasket({
    required this.productId,
    required this.count,
  });

  factory PatchBasketBodyBasket.fromJson(Map<String, dynamic> json)
  => _$PatchBasketBodyBasketFromJson(json);

  Map<String, dynamic> toJson() => _$PatchBasketBodyBasketToJson(this);
}