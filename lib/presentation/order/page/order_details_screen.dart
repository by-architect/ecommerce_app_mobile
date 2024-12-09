import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/orders_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/page/return_details_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../widget/purchase_process_details_widget.dart';
import '../widget/purchase_status_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderModel,
    required this.user,
  });

  final OrderModel orderModel;
  final User user;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final DialogUtil dialogUtil;

  @override
  void initState() {
    dialogUtil = DialogUtil(context);
    BlocProvider.of<OrdersBloc>(context).stream.listen((state) {
      if (state is OrderCancelFailState) {
        dialogUtil.info(
            AppText.errorTitle.capitalizeEveryWord.get, state.fail.userMessage);
      }
      if (state is OrderCancelSuccessState) {
        dialogUtil
            .toast(AppText.orderPageOrderCanceled.capitalizeFirstWord.get);
        Navigator.of(context).pop();
        BlocProvider.of<OrdersBloc>(context)
            .add(GetOrdersEvent(widget.user.uid));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PurchaseSummary purchaseSummary =
        PurchaseSummary(widget.orderModel.products);
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
                                "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${widget.orderModel.id}",
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
                            if (widget.orderModel.purchaseProcessesHandler.one
                                    .dateTime !=
                                null)
                              Text(
                                  "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${(widget.orderModel.purchaseProcessesHandler.one.dateTime!.formatedDate)}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                          ]),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFieldsSmall,
                    ),
                    PurchaseStatusWidget(
                      purchase: widget.orderModel,
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFieldsSmall,
                    ),
                  ],
                )),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            _Title(text: AppText.orderPageProcess.capitalizeFirstWord.get),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSizes.defaultPadding,
              ),
              child: Column(
                children: [
                  PurchaseProcessDetailsWidget(
                      purchaseProcess: widget.orderModel.statusPaid,
                      isProcessing: widget.orderModel.purchaseProcessesHandler
                              .getProcessing ==
                          widget.orderModel.statusPaid),
                  PurchaseProcessDetailsWidget(
                      purchaseProcess: widget.orderModel.statusOrderTaken,
                      isProcessing: widget.orderModel.purchaseProcessesHandler
                              .getProcessing ==
                          widget.orderModel.statusOrderTaken),
                  PurchaseProcessDetailsWidget(
                      purchaseProcess: widget.orderModel.statusShipped,
                      isProcessing: widget.orderModel.purchaseProcessesHandler
                              .getProcessing ==
                          widget.orderModel.statusShipped),
                  PurchaseProcessDetailsWidget(
                      purchaseProcess: widget.orderModel.statusDelivered,
                      isProcessing: widget.orderModel.purchaseProcessesHandler
                              .getProcessing ==
                          widget.orderModel.statusDelivered),
                ],
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
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
                      address: widget.orderModel.address,
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
              children:
                  List.generate(widget.orderModel.products.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwHorizontalFieldsSmall),
                  child: Row(
                    children: [
                      Expanded(
                          child: ProductCardLarge(
                              product:
                                  widget.orderModel.products[index].product,
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
            if (widget.orderModel.purchaseProcessesHandler.getProcessing !=
                    null &&
                widget.orderModel.purchaseProcessesHandler.getProcessing!
                    .cancelableWhileProcessing)
              BlocBuilder<OrdersBloc, OrdersState>(
                builder: (BuildContext context, OrdersState state) =>
                    ButtonSecondary(
                  isLoading: state is OrderCancelLoadingState,
                  onTap: () {
                    dialogUtil.inputDialog(
                      title:
                          AppText.orderPageCancelOrder.capitalizeEveryWord.get,
                      content: AppText
                          .infoTellUsWhatYouDidNotLike.capitalizeEveryWord.get,
                      onAccept: (text) {
                        BlocProvider.of<OrdersBloc>(context).add(
                            CancelOrderEvent(
                                canceledOrder: widget.orderModel,
                                message: text));
                      },
                    );
                  },
                  text: AppText.orderPageCancelOrder.capitalizeFirstWord.get,
                ),
              ),
            if (widget.orderModel.statusDelivered.status ==
                    PurchaseStatus.success &&
                widget.orderModel.activeReturn == null)
              ButtonSecondary(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestReturnScreen(
                            orderModel: widget.orderModel,
                            user: widget.user,
                          )));
                },
                text: AppText.orderPageReturnOrder.capitalizeFirstWord.get,
              ),
            if (widget.orderModel.activeReturn != null)
              ButtonSecondary(
                onTap: () {
                  final activeReturn = widget.orderModel.activeReturn;
                  if (activeReturn != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReturnDetailsScreen(
                              user: widget.user,
                              returnModel: activeReturn,
                            )));
                  }
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
