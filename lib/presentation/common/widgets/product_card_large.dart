import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../sddklibrary/ui/widget_clickable_outlined.dart';
import 'network_image_with_loader.dart';

class ProductCardLarge extends StatelessWidget {
  const ProductCardLarge({super.key, required this.product, required this.onPressed, this.subProductValue});

  final Product product;
  final SubProduct? subProductValue;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    SubProduct subProduct = subProductValue ?? product.subProducts.getIdealSubProduct;
    return ClickableWidgetOutlined(
      minimumSize: const Size(256, 114),
      maximumSize: const Size(256, 114),
      onPressed: onPressed,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(product.firstImageOrEmpty,
                    radius: AppSizes.defaultBorderRadius),
                if (product.images.firstOrNull != null)
                  Positioned(
                    right: AppSizes.defaultPadding / 2,
                    top: AppSizes.defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.defaultBorderRadius)),
                      ),
                      child: Text(
                        "${subProduct.discountPercent}%",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
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
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brandNameOrEmpty.toUpperCase(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: AppSizes.defaultPadding / 2),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      (subProduct.priceAfterDiscounting != 0)
                          ? Row(
                        children: [
                          Text(
                            "\$${subProduct.priceAfterDiscounting}",
                            style: const TextStyle(
                              color: Color(0xFF31B0D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                              width: AppSizes.defaultPadding / 4),
                          Text(
                            "\$${subProduct.price}",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )
                          : Text(
                        "\$${subProduct.price}",
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
