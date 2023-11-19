import 'package:actual_final/common/layout/default_layout.dart';
import 'package:actual_final/product/component/product_card.dart';
import 'package:actual_final/product/component/product_card_11.dart';
import 'package:actual_final/restaurant/component/restaurant_card.dart';
import 'package:actual_final/restaurant/model/restaurant_detail_model.dart';
import 'package:actual_final/restaurant/model/restaurant_model.dart';
import 'package:actual_final/restaurant/provider/restaurant_provider.dart';
import 'package:actual_final/restaurant/provider/restaurant_provider_10.dart';
import 'package:actual_final/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen10 extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen10({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<RestaurantDetailScreen10> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen10> {
  
  @override
  void initState() {
    super.initState();
    
    ref.read(restaurantProvider10.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider10(widget.id));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(
            model: state,
          ),
          if (state is! RestaurantDetailModel)
            renderLoading(),
          if (state is RestaurantDetailModel)
            renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              products: state.products,
            ),
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard11.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
