import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/money.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard(
      {super.key,
      this.isReturn = false,
      required this.purchaseSummary,
      this.showOrderSummaryLabel = true,
      required this.currency});

  final bool isReturn;
  final PurchaseSummary purchaseSummary;
  final bool showOrderSummaryLabel;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.blackBoxDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            if (showOrderSummaryLabel)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppText.cartPageOrderSummary.capitalizeEveryWord.get,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            if (showOrderSummaryLabel)
              const SizedBox(height: AppSizes.spaceBtwVerticalFields),
            _Row(
                title: AppText.cartPageSubtotal.capitalizeFirstWord.get,
                currency: currency,
                amount: purchaseSummary.subtotal),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            _Row(
              title: AppText.cartPageShippingFee.capitalizeEveryWord.get,
              currency: currency,
              amount: purchaseSummary.shippingFee,
              freeEnabled: true,
            ),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            _Row(
                title: AppText.cartPageDiscount.capitalizeFirstWord.get,
                currency: currency,
                amount: purchaseSummary.discount),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            const Divider(),
            const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall),
            _Row(
                title: AppText.cartPageTotal.capitalizeFirstWord.get,
                currency: currency,
                amount: purchaseSummary.total),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final Money amount;
  final bool freeEnabled;
  final Currency currency;

  const _Row({
    super.key,
    required this.title,
    required this.amount,
    this.freeEnabled = false,
    required this.currency,
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
        amount.isZero && freeEnabled
            ? Text(
                AppText.cartPageFree.capitalizeFirstWord.get,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.successColor),
              )
            : Text(
                amount.displayAmount(currency),
                style: Theme.of(context).textTheme.titleMedium,
              )
      ],
    );
  }
}
