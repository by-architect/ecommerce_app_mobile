import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_availability_tag.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_quantity.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/network_image_with_loader.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    this.onPressed,
    this.style,
    required this.cartItem, required this.onIncrement, required this.onDecrement, required this.numOfItem,
  });

  final CartItem cartItem;
  final int numOfItem;
  final VoidCallback? onPressed;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ClickableWidgetOutlined(
      minimumSize: const Size(256, 114),
      maximumSize: const Size(256, 114),
      onPressed: cartItem.productWithQuantity.subProduct.availableInStock ? () {} : null,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(cartItem.productWithQuantity.product.firstImageOrEmpty,
                    radius: AppSizes.defaultBorderRadius),
                if (cartItem.productWithQuantity.product.images.firstOrNull != null)
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
                        "${cartItem.productWithQuantity.subProduct.discountPercent}%",
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
                        cartItem.productWithQuantity.product.brandNameOrEmpty.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: AppSizes.defaultPadding / 2),
                      Text(
                        cartItem.productWithQuantity.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      cartItem.productWithQuantity.subProduct.priceAfterDiscounting != 0
                          ? Row(
                              children: [
                                Text(
                                  "\$${cartItem.productWithQuantity.subProduct.priceAfterDiscounting}",
                                  style: const TextStyle(
                                    color: Color(0xFF31B0D8),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                    width: AppSizes.defaultPadding / 4),
                                Text(
                                  "\$${cartItem.productWithQuantity.subProduct.price}",
                                  style: TextStyle(
                                    color: Theme.of(context)
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
                              "\$${cartItem.productWithQuantity.subProduct.price}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                    ],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cartItem.productWithQuantity.subProduct.availableInStock
                          ? ProductQuantity(
                              numOfItem: numOfItem,
                              onIncrement: onIncrement,
                              onDecrement: onDecrement,
                              isSmall: true,
                            )
                          : const ProductAvailabilityTag(
                            isAvailable: false,
                            isSmall: true,
                          )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
