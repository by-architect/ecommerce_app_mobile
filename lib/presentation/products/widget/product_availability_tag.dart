import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    super.key,
    required this.isAvailable,
    this.isSmall = false,
  });

  final bool isAvailable;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.successColor : AppColors.errorColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.defaultBorderRadius / 2),
        ),
      ),
      child: isSmall
          ? Text(
              isAvailable
                  ? AppText.productPageAvailableInStockSmall.capitalizeFirstWord
                  : AppText.productPageUnAvailableInStockSmall.capitalizeFirstWord,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w100),
            )
          : Text(
              isAvailable
                  ? AppText.productPageAvailableInStock.capitalizeFirstWord
                  : AppText.productPageUnAvailableInStock.capitalizeFirstWord,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
    );
  }
}
