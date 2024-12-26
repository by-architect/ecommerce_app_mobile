import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature_handler.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product.dart';
import '../../../data/model/user.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.previousProduct,
    this.press,
    this.previousProductFeatureHandler,required this.user, required this.appSettings, required this.currency,
  });

  final Product product;
  final Product? previousProduct;
  final ProductFeatureHandler? previousProductFeatureHandler;
  final VoidCallback? press;
  final User? user;
  final AppSettings appSettings;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    SubProduct idealSubProduct = product.subProducts.getIdealSubProduct;
    return OutlinedButton(
      onPressed: () {
        if (press != null) {
          press!();
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            product: product,
            appSettings: appSettings,
            previousProduct: previousProduct,
            previousProductFeatureHandler: previousProductFeatureHandler,
            user: user,
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
                  product.firstImageOrEmpty,
                  radius: AppSizes.defaultBorderRadius,
                ),
                if (idealSubProduct.hasDiscount)
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
                        "${idealSubProduct.discountPercent}% ${AppText.commonPageOff}",
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
                  Flexible(
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                    ),
                  ),
                  const Spacer(),
                  product.subProducts.getIdealSubProduct.discountPercent != 0
                      ? Row(
                          children: [
                            Text(
                              idealSubProduct.priceAfterDiscounting.displayAmount(currency),
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: AppSizes.defaultPadding / 4),
                            Text(
                              idealSubProduct.price.displayAmount(currency),
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
                              idealSubProduct.price.displayAmount(currency),
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
