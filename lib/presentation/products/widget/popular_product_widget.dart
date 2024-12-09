import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_card_skeleton.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product.dart';
import '../../../data/model/user.dart';
import '../../common/widgets/product_card.dart';

class ProductsHorizontalWidget extends StatelessWidget {
  final List<Product> products;
  final AllProductFeatures productFeatures;
  final String title;
  final bool isLoading;
  final User? user;
  final AppSettings appSettings;

  const ProductsHorizontalWidget({
    super.key,
    required this.products,
    required this.title,
    required this.isLoading,
    required this.productFeatures,
    required this.user, required this.appSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSizes.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoPopularProducts on models/ProductModel.dart
            itemCount: isLoading ? 10 : products.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: AppSizes.defaultPadding,
                right: index == products.length - 1 ? AppSizes.defaultPadding : 0,
              ),
              child: isLoading
                  ? const ProductCardSkeleton()
                  : ProductCard(
                appSettings: appSettings,
                      user: user,
                      product: products[index],
                    ),
            ),
          ),
        )
      ],
    );
  }
}
