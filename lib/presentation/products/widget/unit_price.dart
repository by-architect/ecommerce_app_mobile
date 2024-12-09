import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:flutter/material.dart';

class UnitPrice extends StatelessWidget {
  const UnitPrice({
    super.key,
    this.subProduct, required this.currency,
  });

  final SubProduct? subProduct;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.productPageUnitPrice.capitalizeEveryWord.get,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSizes.defaultPadding / 1),
        Text.rich(
          TextSpan(
            text: subProduct == null
                ? "${currency.sign}..."
                : subProduct!.hasDiscount
                    ? "${currency.sign}${subProduct?.priceAfterDiscounting.toStringAsFixed(2)}  "
                    : "${currency.sign}${subProduct?.price.toStringAsFixed(2)}  ",
            style: Theme.of(context).textTheme.titleLarge,
            children: [
              if (subProduct != null && subProduct!.hasDiscount)
                TextSpan(
                  text: "${currency.sign}${subProduct?.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color, decoration: TextDecoration.lineThrough),
                ),
            ],
          ),
        )
      ],
    );
  }
}
