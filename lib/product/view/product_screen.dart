import 'package:actual_final/common/component/pagination_list_view.dart';
import 'package:actual_final/product/component/product_card.dart';
import 'package:actual_final/product/model/product_model.dart';
import 'package:actual_final/product/provider/product_provider.dart';
import 'package:actual_final/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => RestaurantDetailScreen(
            //       id: model.restaurant.id,
            //     ),
            //   ),
            // );
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {
                'rid': model.restaurant.id,
              },
            );
          },
          child: ProductCard.fromProductModel(
            model: model,
          ),
        );
      },
    );
  }
}
