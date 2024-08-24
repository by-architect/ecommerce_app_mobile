import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.previousProduct,
    this.press,
  });

  final Product product;
  final Product? previousProduct;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (press != null) {
          press!();
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            product: product,
            previousProduct: previousProduct,
          ),
        ));
      },
      style:
          OutlinedButton.styleFrom(minimumSize: const Size(140, 220), maximumSize: const Size(140, 220), padding: const EdgeInsets.all(8)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(
                  product.images.firstOrNull ?? "",
                  radius: AppSizes.defaultBorderRadius,
                ),
                if (product.discount != 0)
                  Positioned(
                    right: AppSizes.defaultPadding / 2,
                    top: AppSizes.defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.errorColor,
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
                      ),
                      child: Text(
                        "${product.discountPercent}% ${AppText.commonPageOff}",
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding / 2, vertical: AppSizes.defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.brandName != null
                      ? Text(
                          product.brandName!.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: AppSizes.defaultPadding / 2),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  product.discount != 0
                      ? Row(
                          children: [
                            Text(
                              "\$${product.priceAfterDiscounting}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: AppSizes.defaultPadding / 4),
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium!.color,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              "\$${product.price}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
