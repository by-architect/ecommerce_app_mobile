import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
    required this.numOfItem,
    required this.onIncrement,
    required this.onDecrement,
    this.isSmall = false,
    required this.deleteButtonActive, this.maxQuantity,
  });

  final int? numOfItem;
  final int? maxQuantity;
  final VoidCallback onIncrement, onDecrement;
  final bool isSmall;
  final bool deleteButtonActive;

  @override
  Widget build(BuildContext context) {
    const double largeSize = 40;
    const double smallSize = 30;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSmall)
          Text(
            AppText.productPageQuantity.capitalizeFirstWord.get,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        if (!isSmall) const SizedBox(height: AppSizes.defaultPadding),
        Row(
          children: [
            SizedBox(
              height: isSmall ? smallSize : largeSize,
              width: isSmall ? smallSize : largeSize,
              child: OutlinedButton(
                onPressed: onDecrement,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(AppSizes.defaultPadding / 2)),
                child: deleteButtonActive
                    ? SvgPicture.asset(
                        AppImages.deleteIcon,
                        colorFilter: ColorFilters.errorColorFilter,
                      )
                    : SvgPicture.asset(
                        AppImages.minusIcon,
                        colorFilter: ColorFilters.iconThemeColor(context),
                      ),
              ),
            ),
            SizedBox(
              width: isSmall ? maxQuantity == null ? smallSize : smallSize *3/2 : maxQuantity == null ? largeSize : largeSize *3/2, height: isSmall ? smallSize : largeSize,
              child: Center(
                child: Text(
                  numOfItem == null ? "?" : maxQuantity == null ? numOfItem.toString() : " $numOfItem/$maxQuantity ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: isSmall ? smallSize : largeSize,
              width: isSmall ? smallSize : largeSize,
              child: OutlinedButton(
                onPressed: onIncrement,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(AppSizes.defaultPadding / 2)),
                child: SvgPicture.asset(
                  AppImages.plusIcon,
                  colorFilter: ColorFilters.iconThemeColor(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
