import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/network_image_with_loader.dart';

class SecondaryProductCard extends StatelessWidget {
  const SecondaryProductCard({
    super.key,
    this.press,
    this.style,
    required this.product,
  });

  final Product product;
  final VoidCallback? press;

  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final idealSubProduct = product.subProducts.getIdealSubProduct;
    return OutlinedButton(
      onPressed: () {},
      style: style ??
          OutlinedButton.styleFrom(minimumSize: const Size(256, 114), maximumSize: const Size(256, 114), padding: const EdgeInsets.all(8)),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(product.firstImageOrEmpty, radius: AppSizes.defaultBorderRadius),
                if (product.images.firstOrNull != null)
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
                        "${idealSubProduct.discountPercent}% off",
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(width: AppSizes.defaultPadding / 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brandNameOrEmpty.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: AppSizes.defaultPadding / 2),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  idealSubProduct.priceAfterDiscounting !=0
                      ? Row(
                          children: [
                            Text(
                              "\$${idealSubProduct.priceAfterDiscounting}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: AppSizes.defaultPadding / 4),
                            Text(
                              "\$${idealSubProduct.price}",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium!.color,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "\$${idealSubProduct.price}",
                          style: const TextStyle(
                            color: Color(0xFF31B0D8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
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
