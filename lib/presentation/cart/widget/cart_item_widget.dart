import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_availability_tag.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_quantity.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/network_image_with_loader.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget.fromProduct({
    super.key,
    required this.product,
    required this.subProduct,
    this.style,
    required this.currency,
  })  : numOfItem = null,
        maxQuantity = null,
        onIncrement = null,
        onDecrement = null,
        isReturn = false,
        deleteButtonEnabled = false;

  CartItemWidget.fromCartItem({
    super.key,
    required CartItem cartItem,
    required this.onIncrement,
    required this.onDecrement,
    this.style,
    required this.currency,
  })  : product = cartItem.productWithQuantity.product,
        subProduct = cartItem.productWithQuantity.subProduct,
        numOfItem = cartItem.productWithQuantity.quantity,
        maxQuantity = null,
        isReturn = false,
        deleteButtonEnabled = true;

  CartItemWidget.fromReturnItem({
    super.key,
    required ProductWithQuantity productWithQuantity,
    required this.onIncrement,
    required this.onDecrement,
    this.maxQuantity,
    this.style,
    required this.currency,
  })  : product = productWithQuantity.product,
        subProduct = productWithQuantity.subProduct,
        numOfItem = productWithQuantity.quantity,
        isReturn = true,
        deleteButtonEnabled = false;

  final Product product;
  final SubProduct subProduct;
  final int? numOfItem;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final bool deleteButtonEnabled;
  final ButtonStyle? style;
  final bool isReturn;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ClickableWidgetOutlined(
      minimumSize: const Size(256, 114),
      maximumSize: const Size(256, 114),
      onPressed: subProduct.availableInStock || isReturn ? () {} : null,
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: AppSizes.defaultPadding / 2),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      !subProduct.priceAfterDiscounting.isZero
                          ? Row(
                              children: [
                                Text(
                                  subProduct.priceAfterDiscounting
                                      .displayAmount(currency),
                                  style: const TextStyle(
                                    color: Color(0xFF31B0D8),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                    width: AppSizes.defaultPadding / 4),
                                Text(
                                  subProduct.price.displayAmount(currency),
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
                              subProduct.price.displayAmount(currency),
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                    ],
                  ),
                  if (numOfItem != null &&
                      onIncrement != null &&
                      onDecrement != null)
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        subProduct.availableInStock || isReturn
                            ? ProductQuantity(
                                numOfItem: numOfItem,
                                onIncrement: onIncrement!,
                                onDecrement: onDecrement!,
                                maxQuantity: maxQuantity,
                                deleteButtonActive:
                                    deleteButtonEnabled && numOfItem == 1,
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
