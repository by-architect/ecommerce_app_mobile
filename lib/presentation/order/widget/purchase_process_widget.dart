import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/model/order.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process_interface.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/order_summary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/product_card_large.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_button_default.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';
import 'purchase_status_widget.dart';

class PurchaseProcessWidget extends StatelessWidget {
  const PurchaseProcessWidget(
      {super.key, required this.purchase, required this.onCancel});

  final Purchase purchase;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    PurchaseSummary purchaseSummary = PurchaseSummary(purchase.products);
    return Container(
      decoration: AppStyles.defaultBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: Column(children: [
          Row(
            children: [
              Text(
                "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${purchase.id}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.whiteColor60),
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          Row(children: [
            Text(
                "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${purchase.purchaseProcessesHandler.one.dateTime.formatedDate}",
                style: Theme.of(context).textTheme.titleMedium),
          ]),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          const Divider(),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields,
          ),
          PurchaseStatusWidget(purchase: purchase,),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields,
          ),
          Column(
            children: List.generate(purchase.products.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(
                    AppSizes.spaceBtwHorizontalFieldsSmall),
                child: Row(
                  children: [
                    Expanded(
                        child: ProductCardLarge(
                            product: purchase.products[index].product,
                            onPressed: () {})),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          OrderSummaryCard(
            purchaseSummary: purchaseSummary,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          if (purchase.purchaseProcessesHandler.getProcessing != null &&
              purchase.purchaseProcessesHandler.getProcessing!
                  .cancelableWhileProcessing)
            Row(
              children: [
                TextButtonDefault(
                  onPressed: onCancel,
                  text: AppText.cancel.capitalizeFirstWord.get,
                  color: AppColors.errorColor,
                ),
              ],
            )
        ]),
      ),
    );
  }
}
