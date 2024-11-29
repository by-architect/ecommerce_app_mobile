import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/product_card_large.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/user.dart';
import '../page/order_details_screen.dart';
import '../../return/page/request_return_screen.dart';
import 'purchase_status_widget.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderModel,
    required this.onCancel,
    required this.user,
  });

  final OrderModel orderModel;
  final Function() onCancel;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ClickableWidgetOutlined(
      style: AppStyles.clickableWidgetOutlinedStyleNoPadding(context),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(
                  orderModel: orderModel,
                  onCancel: onCancel,
                  onReturn: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RequestReturnScreen(
                              orderModel: orderModel,
                              user: user,
                            )));
                  },
                )));
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${orderModel.id}",
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
                    "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${orderModel.purchaseProcessesHandler.one.dateTime.formatedDate}",
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
                purchase: orderModel,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              Column(
                children: List.generate(orderModel.products.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(
                        AppSizes.spaceBtwHorizontalFieldsSmall),
                    child: Row(
                      children: [
                        Expanded(
                            child: ProductCardLarge(
                                product: orderModel.products[index].product,
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
