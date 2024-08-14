import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_card_skeleton.dart';
import 'package:flutter/material.dart';


class ProductsSkeleton extends StatelessWidget {
  const ProductsSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: AppSizes.defaultPadding,
            right: index == 4 ? AppSizes.defaultPadding : 0,
          ),
          child: const ProductCardSkeleton(),
        ),
      ),
    );
  }
}

