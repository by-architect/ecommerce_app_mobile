import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/order_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/order_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/request_return_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/returns_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/returns_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/fakerepository/fake_app_defaults.dart';
import '../../../data/model/purchase_process.dart';
import '../../../sddklibrary/ui/widget_clickable_outlined.dart';
import '../../common/widgets/app_bar_pop_back.dart';
import '../../common/widgets/button_secondary.dart';
import '../../common/widgets/product_card_large.dart';
import '../../order/widget/purchase_status_widget.dart';

class ReturnDetailsScreen extends StatefulWidget {
  const ReturnDetailsScreen({
    super.key,
    required this.returnModel,
    required this.user,
  });

  final ReturnModel returnModel;
  final User user;

  @override
  State<ReturnDetailsScreen> createState() => _ReturnDetailsScreenState();
}

class _ReturnDetailsScreenState extends State<ReturnDetailsScreen> {
  late final DialogUtil dialogUtil;

  @override
  void initState() {
    dialogUtil = DialogUtil(context);
    BlocProvider.of<ReturnsBloc>(context).stream.listen((state) {
      if (state is CancelReturnSuccessState) {
        dialogUtil
            .toast(AppText.orderPageReturnCanceled.capitalizeFirstWord.get);

        Navigator.of(context).pop();

        BlocProvider.of<ReturnsBloc>(context)
            .add(GetReturnsEvent(widget.user.uid));

        BlocProvider.of<OrdersBloc>(context)
            .add(GetOrdersEvent(widget.user.uid));
      }
      if (state is CancelReturnFailedState) {
        dialogUtil.info(
            AppText.errorTitle.capitalizeEveryWord.get, state.fail.userMessage);
      }
    });
    super.initState();
  }

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
                                "${AppText.orderPageOrder.capitalizeEveryWord.get}    #${widget.returnModel.id}",
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
                                "${AppText.orderPagePlacedOn.capitalizeEveryWord.get}    ${widget.returnModel.purchaseProcessesHandler.one.dateTime?.formatedDate}",
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
                      purchase: widget.returnModel,
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
                  _Process(
                      purchaseProcess:
                          widget.returnModel.statusReturnRequested),
                  _Process(
                      purchaseProcess:
                          widget.returnModel.statusRequestAccepted),
                  _Process(
                      purchaseProcess: widget.returnModel.statusReturnShipped),
                  _Process(
                      purchaseProcess:
                          widget.returnModel.statusReturnDelivered),
                  _Process(
                      purchaseProcess: widget.returnModel.statusReturnAccepted),
                ],
              ),
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
                  List.generate(widget.returnModel.products.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spaceBtwHorizontalFieldsSmall),
                  child: Row(
                    children: [
                      Expanded(
                          child: ProductCardLarge(
                              product:
                                  widget.returnModel.products[index].product,
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
            if (widget.returnModel.purchaseProcessesHandler.getProcessing !=
                    null &&
                widget.returnModel.purchaseProcessesHandler.getProcessing!
                    .cancelableWhileProcessing)
              BlocBuilder<ReturnsBloc, ReturnsState>(
                builder: (BuildContext context, ReturnsState state) =>
                    ButtonSecondary(
                  isLoading: state is CancelReturnLoadingState,
                  onTap: () {
                    dialogUtil.inputDialog(
                      title: AppText
                          .returnPageCancelReturn.capitalizeEveryWord.get,
                      content: AppText
                          .infoTellUsWhyYouCancelReturn.capitalizeEveryWord.get,
                      onAccept: (text) {
                        BlocProvider.of<ReturnsBloc>(context).add(
                            CancelReturnEvent(
                                returnModel: widget.returnModel,
                                uid: widget.user.uid,
                                message: text));
                      },
                    );
                  },
                  text: AppText.orderPageCancelOrder.capitalizeFirstWord.get,
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

class _Process extends StatelessWidget {
  const _Process({super.key, required this.purchaseProcess});

  final PurchaseProcess purchaseProcess;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Text(purchaseProcess.purchaseStatusType.userText.get,
            style: Theme.of(context).textTheme.titleSmall),
      ]),
      const SizedBox(
        height: AppSizes.spaceBtwVerticalFieldsSmall,
      ),
      Column(
        children: [
          if (purchaseProcess.dateTime != null)
            Row(
              children: [
                Text(
                  purchaseProcess.dateTime!.formatedDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          Row(
            children: [
              Text(
                "${AppText.status.capitalizeFirstWord.get}: ${purchaseProcess.status.userText}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          if (purchaseProcess.message != null)
            Row(
              children: [
                Text(
                  "${AppText.message.capitalizeFirstWord.get}: ${purchaseProcess.message!}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFieldsSmall,
          ),
          if (purchaseProcess.cargoNo != null)
            Row(
              children: [
                Text(
                  "${AppText.orderPageCargoNo.capitalizeFirstWord.get}: ${purchaseProcess.cargoNo!}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (purchaseProcess.cargoNo != null)
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsSmall,
            )
        ],
      )
    ]);
  }
}
