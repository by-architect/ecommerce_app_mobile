import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/purchase_process.dart';

class PurchaseProcessDetailsWidget extends StatelessWidget {
  const PurchaseProcessDetailsWidget({super.key, required this.purchaseProcess,  required this.isProcessing});

  final PurchaseProcess purchaseProcess;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    return  purchaseProcess.status == PurchaseStatus.waiting && !isProcessing ? const SizedBox.shrink(): Column(children: [
      Row(children: [
        Flexible(
          child: Text(purchaseProcess.purchaseStatusType.userText.get,
              style: Theme.of(context).textTheme.titleSmall),
        ),
      ]),
      const SizedBox(
        height: AppSizes.spaceBtwVerticalFieldsSmall,
      ),
      Column(
        children: [
          if (purchaseProcess.dateTime != null)
            Row(
              children: [
                Flexible(
                  child: Text(
                    purchaseProcess.dateTime!.formatedDate,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          if (purchaseProcess.dateTime != null)
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                 isProcessing ? "${AppText.status.capitalizeFirstWord.get}: ${AppText.processing}" : "${AppText.status.capitalizeFirstWord.get}: ${purchaseProcess.status.userText}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          if (purchaseProcess.message != null)
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${AppText.message.capitalizeFirstWord.get}: ${purchaseProcess.message!}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          if (purchaseProcess.message != null)
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          if (purchaseProcess.cargoNo != null)
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${AppText.orderPageCargoNo.capitalizeFirstWord.get}: ${purchaseProcess.cargoNo!}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          if (purchaseProcess.cargoNo != null)
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsSmall,
            ),
        ],
      )
    ]);
  }
}
