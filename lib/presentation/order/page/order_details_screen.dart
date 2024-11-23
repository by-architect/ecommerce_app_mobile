import 'package:ecommerce_app_mobile/data/model/order.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../common/util/cart_util.dart';
import '../../cart/widget/order_summary.dart';
import '../../common/widgets/product_card_large.dart';
import '../../common/widgets/text_button_default.dart';
import '../widget/purchase_status_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen(
      {super.key, required this.orderModel, required this.onCancel});

  final OrderModel orderModel;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    PurchaseSummary purchaseSummary = PurchaseSummary(orderModel.products);
    return Scaffold(
      appBar: const AppBarPopBack(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: SingleChildScrollView(
          child: Column(children: [
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
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsSmall,
            ),
            const Divider(),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            PurchaseStatusWidget(
              purchase: orderModel,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Row(
              children: [
                Text(
                  AppText.addressesPageAddress.capitalizeFirstWord.get,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Row(
              children: [
                Expanded(
                  child: AddressCard(
                      address: orderModel.address,
                      isSelected: false,
                      onSelected: () {}),
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            Row(
              children: [
                Text(
                  AppText.orderPageProducts.capitalizeFirstWord.get,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
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
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            Row(
              children: [
                Text(
                  AppText.cartPageOrderSummary.capitalizeFirstWord.get,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            OrderSummaryCard(
              purchaseSummary: purchaseSummary,
              showOrderSummaryLabel: false,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            if (orderModel.purchaseProcessesHandler.getProcessing != null &&
                orderModel.purchaseProcessesHandler.getProcessing!
                    .cancelableWhileProcessing)
              Padding(
                padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
                child: ButtonSecondary(
                  onTap: onCancel,
                  text: AppText.cancel.capitalizeFirstWord.get,
                ),
              ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
          ]),
        ),
      ),
    );
  }
}
