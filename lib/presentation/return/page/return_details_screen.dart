import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/fakerepository/fake_app_defaults.dart';
import '../../../sddklibrary/ui/widget_clickable_outlined.dart';
import '../../common/widgets/app_bar_pop_back.dart';
import '../../common/widgets/button_secondary.dart';
import '../../common/widgets/product_card_large.dart';
import '../../order/widget/purchase_status_widget.dart';

class ReturnDetailsScreen extends StatelessWidget {
  const ReturnDetailsScreen({super.key, required this.returnModel, required this.onCancel});

  final ReturnModel returnModel;
  final Function(ReturnModel) onCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.returnPageReturnDetails.capitalizeEveryWord.get,
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
                                "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${returnModel.id}",
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
                                "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${returnModel.purchaseProcessesHandler.one.dateTime?.formatedDate}",
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
                      purchase: returnModel,
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
              text: AppText.orderPageProducts.capitalizeFirstWord.get,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Column(
              children: List.generate(returnModel.products.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwHorizontalFieldsSmall),
                  child: Row(
                    children: [
                      Expanded(
                          child: ProductCardLarge(
                              product: returnModel.products[index].product,
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
            //todo: handle now
            if (returnModel.purchaseProcessesHandler.getProcessing != null &&
                returnModel.purchaseProcessesHandler.getProcessing!
                    .cancelableWhileProcessing)
              ButtonSecondary(
                onTap: onCancel(returnModel),
                text: AppText.orderPageCancelOrder.capitalizeFirstWord.get,
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
