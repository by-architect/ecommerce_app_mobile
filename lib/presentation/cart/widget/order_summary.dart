import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    this.isReturn = false,
    required this.date,
    required this.amount,
    required this.product,
  });

  final bool isReturn;
  final String date;
  final double amount;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppText.cartPageOrderSummary.capitalizeEveryWord,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwVerticalFields),
            _Row(title: AppText.cartPageSubtotal.capitalizeFirstWord, amount: "23"),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            _Row(
              title: AppText.cartPageShippingFee.capitalizeEveryWord,
            ),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            _Row(title: AppText.cartPageDiscount.capitalizeFirstWord, amount: "23"),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            const Divider(),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            _Row(title: AppText.cartPageTotal.capitalizeFirstWord, amount: "23"),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String? amount;

  const _Row({
    super.key,
    required this.title,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
        amount == null
            ? Text(
                AppText.cartPageFree.capitalizeFirstWord,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.successColor),
              )
            : Text(
                "\$$amount",
                style: Theme.of(context).textTheme.titleMedium,
              )
      ],
    );
  }
}
