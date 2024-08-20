import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_card_skeleton.dart';
import 'package:flutter/material.dart';


class ProductsSkeleton extends StatelessWidget {
  const ProductsSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProductCardSkeleton(),
          ProductCardSkeleton(),
        ],
      ),
    );
  }
}

