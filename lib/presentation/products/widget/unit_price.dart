import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';


class UnitPrice extends StatelessWidget {
  const UnitPrice({
    super.key,
    required this.price,
    this.priceAfterDiscount,
  });

  final double? price;
  final double? priceAfterDiscount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.productPageUnitPrice.capitalizeEveryWord,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSizes.defaultPadding / 1),
        Text.rich(
          TextSpan(
            text:price == null ? "\$...": priceAfterDiscount == null
                ? "\$${price?.toStringAsFixed(2)}  "
                : "\$${priceAfterDiscount!.toStringAsFixed(2)}  ",
            style: Theme.of(context).textTheme.titleLarge,
            children: [
              if (priceAfterDiscount != null)
                TextSpan(
                  text: "\$${price?.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      decoration: TextDecoration.lineThrough),
                ),
            ],
          ),
        )
      ],
    );
  }
}
