import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/review_product_info_card.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/review_user_card.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';
import 'order_process_widget.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({super.key, required this.purchaseProcess});

  final PurchaseProcess purchaseProcess;

  @override
  Widget build(BuildContext context) {
    return ClickableWidgetOutlined(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${purchaseProcess.id}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor60),
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsSmall,
            ),
            Row(children: [
              Text(
                  "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${purchaseProcess.processStatusList.firstWhere((element) => element.purchaseStatusType == PurchaseStatusType.payingSuccess).dateTime.formatedDate}",
                  style: Theme.of(context).textTheme.titleMedium),
            ]),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsSmall,
            ),
            const Divider(),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            OrderProgressWidget(purchaseProcess: purchaseProcess),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
/*
            ListView.builder(
              itemBuilder: (context, index) => ,
              itemCount: purchaseProcess.selectedProducts.length,
            )
*/
          ]),
        ));
  }
}
