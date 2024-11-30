import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../common/util/cart_util.dart';
import '../../../data/model/purchase_process.dart';
import '../../../data/model/user.dart';
import '../../cart/widget/order_summary.dart';
import '../../common/widgets/product_card_large.dart';
import '../../common/widgets/text_button_default.dart';
import '../../return/page/request_return_screen.dart';
import '../widget/purchase_status_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen(
      {super.key,
      required this.orderModel,
      required this.onCancel, required this.user,
      });

  final OrderModel orderModel;
  final User user;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    PurchaseSummary purchaseSummary = PurchaseSummary(orderModel.products);
    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.orderPageOrderDetails.capitalizeEveryWord.get,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(children: [
            ClickableWidgetOutlined(
                onPressed: () {},
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(AppSizes.defaultPadding / 2),
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
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFieldsSmall,
                    ),
                    PurchaseStatusWidget(
                      purchase: orderModel,
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFieldsSmall,
                    ),
                  ],
                )),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            _Title(
              text: AppText.addressesPageAddress.capitalizeFirstWord.get,
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
            _Title(
              text: AppText.orderPageProducts.capitalizeFirstWord.get,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Column(
              children: List.generate(orderModel.products.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwHorizontalFieldsSmall),
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
            _Title(
              text: AppText.cartPageOrderSummary.capitalizeFirstWord.get,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            OrderSummaryCard(
              purchaseSummary: purchaseSummary,
              showOrderSummaryLabel: false,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.infoNeedHelpWithAnything.capitalizeFirstWord.get,
                      style: TextStyle(
                          color: Theme.of(context).dividerColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFieldsSmall,
                    ),
                    ...List.generate(
                        FakeAppDefaults.supportContacts.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(
                                  top: AppSizes.spaceBtwVerticalFieldsSmall / 2,
                                  bottom:
                                      AppSizes.spaceBtwVerticalFieldsSmall / 2,
                                  left: AppSizes.tabSpace),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        FakeAppDefaults
                                            .supportContacts[index]
                                            .type
                                            .userText
                                            .addColon
                                            .capitalizeFirstWord
                                            .get,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(
                                        width:
                                            AppSizes.spaceBtwHorizontalFields,
                                      ),
                                      Text(
                                        FakeAppDefaults
                                            .supportContacts[index].content,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            if (orderModel.purchaseProcessesHandler.getProcessing != null &&
                orderModel.purchaseProcessesHandler.getProcessing!
                    .cancelableWhileProcessing)
              ButtonSecondary(
                onTap: onCancel,
                text: AppText.orderPageCancelOrder.capitalizeFirstWord.get,
              ),
            if (orderModel.statusDelivered.status == PurchaseStatus.success && orderModel.activeReturn == null)
              ButtonSecondary(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestReturnScreen(
                        orderModel: orderModel,
                        user: user,
                      )));
                },
                text: AppText.orderPageReturnOrder.capitalizeFirstWord.get,
              ),
            if(orderModel.activeReturn != null)
              ButtonSecondary(
                onTap: (){
                  //todo: return details screen
                },
                text: AppText.returnPageReturnDetails.capitalizeFirstWord.get,
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

class _Title extends StatelessWidget {
  const _Title({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
