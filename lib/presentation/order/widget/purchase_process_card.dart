import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/product_card_large.dart';
import 'package:ecommerce_app_mobile/presentation/return/page/return_details_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/user.dart';
import '../page/order_details_screen.dart';
import 'purchase_status_widget.dart';

class PurchaseCard extends StatelessWidget {
  const PurchaseCard({
    super.key,
    required this.purchaseModel,
    required this.onOrderCancel,
    required this.user, required this.onReturnCancel,
  });

  final PurchaseModel purchaseModel;
  final Function() onOrderCancel;
  final Function(ReturnModel) onReturnCancel;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ClickableWidgetOutlined(
      style: AppStyles.clickableWidgetOutlinedStyleNoPadding(context),
      onPressed: () {
        if (purchaseModel is OrderModel) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                    orderModel: purchaseModel as OrderModel,
                    onOrderCancel: onOrderCancel,
                    onReturnCancel: onReturnCancel,
                    user: user,
                  )));
        }
        if (purchaseModel is ReturnModel) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReturnDetailsScreen(
                    returnModel: purchaseModel as ReturnModel,
                    onCancel: onReturnCancel,
                  )));
        }
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                   purchaseModel is OrderModel ? "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${purchaseModel.id}" : "${AppText.returnPageReturn.capitalizeEveryWord.get}    #${purchaseModel.id}",
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
                    "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${purchaseModel.purchaseProcessesHandler.one.dateTime?.formatedDate}",
                    style: Theme.of(context).textTheme.titleMedium),
              ]),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
          child: Column(
            children: [
              PurchaseStatusWidget(
                purchase: purchaseModel,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              Column(
                children: List.generate(purchaseModel.products.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(
                        AppSizes.spaceBtwHorizontalFieldsSmall),
                    child: Row(
                      children: [
                        Expanded(
                            child: ProductCardLarge(
                                product: purchaseModel.products[index].product,
                                onPressed: () {})),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
