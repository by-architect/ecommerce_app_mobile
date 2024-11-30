import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/widget/text_field_explanation.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppText.dart';
import '../../../data/usecase/return_request_validation.dart';

class RequestReturnScreen extends StatefulWidget {
  const RequestReturnScreen(
      {super.key, required this.orderModel, required this.user});

  final OrderModel orderModel;
  final User user;

  @override
  State<RequestReturnScreen> createState() => _RequestReturnScreenState();
}

class _RequestReturnScreenState extends State<RequestReturnScreen> {
  late final DialogUtil dialogUtil;

  @override
  void initState() {
    dialogUtil = DialogUtil(context);
    BlocProvider.of<ReturnDetailsBloc>(context).add(ClearReturnStateEvent());
    final productBaseList = widget.orderModel.products.toList();
    for (int i = 0; i < productBaseList.length; i++) {
      productBaseList[i] = productBaseList[i].setQuantity(0);
    }
    Log.test(title: "productBaseList", data: productBaseList[0].quantity);
    BlocProvider.of<ReturnDetailsBloc>(context)
        .add(InitialProductsEvent(products: productBaseList));

    BlocProvider.of<ReturnDetailsBloc>(context).stream.listen((state) {
      if (state is ReturnRequestFailState) {
        dialogUtil.info(
            AppText.errorTitle.capitalizeEveryWord.get, state.fail.userMessage);
      }
      if (state is ReturnRequestSuccessState) {
        dialogUtil.toast(
            AppText.infoReturnRequestedSuccessfully.capitalizeFirstWord.get);
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReturnDetailsBloc, ReturnDetailsState>(
      builder: (BuildContext context, ReturnDetailsState state) => Scaffold(
        appBar: AppBarPopBack(
          title: AppText.requestReturnPageRequestReturn.capitalizeEveryWord.get,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: widget
                  .orderModel.statusDelivered.hasTheRightOfWithdrawalExpired
              ? SingleChildScrollView(
                  child: Column(children: [
                    _Title(
                        text: AppText.requestReturnPageSelectReason
                            .capitalizeEveryWord.get),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    ...ReturnType.values.map((e) {
                      return ReturnType.unselected != e
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      AppSizes.spaceBtwVerticalFieldsSmall / 2),
                              child: ClickableWidgetOutlined(
                                isSelected: state.returnType == e,
                                onPressed: () {
                                  BlocProvider.of<ReturnDetailsBloc>(context)
                                      .add(ReturnTypeEvent(e));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      AppSizes.defaultPadding / 3),
                                  child: Text(
                                    e.userText.capitalizeFirstWord.get,
                                    style: state.returnType == e
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)
                                        : null,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    SizedBox(
                        height: 200,
                        child: TextFieldExplanation(
                          hint: AppText
                              .infoExplainWhyYouReturn.capitalizeFirstWord.get,
                          maxLength: 500,
                          onChanged: (text) {
                            BlocProvider.of<ReturnDetailsBloc>(context)
                                .add(ReturnReasonEvent(text));
                          },
                        )),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    _Title(
                        text:
                            AppText.orderPageProducts.capitalizeEveryWord.get),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                    ...List.generate(state.products.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.defaultPadding / 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: CartItemWidget.fromReturnItem(
                                  productWithQuantity: state.products[index],
                                  maxQuantity: widget
                                      .orderModel.products[index].quantity,
                                  onIncrement: () {
                                    if (state.products[index].quantity <
                                        widget.orderModel.products[index]
                                            .quantity) {
                                      BlocProvider.of<ReturnDetailsBloc>(context)
                                        .add(SelectedProductEvent(
                                            product: state.products[index]
                                                .increaseQuantity(),
                                            index: index));
                                    }
                                  },
                                  onDecrement: () {
                                    if (state.products[index].quantity > 0) {
                                      BlocProvider.of<ReturnDetailsBloc>(
                                              context)
                                          .add(SelectedProductEvent(
                                              product: state.products[index]
                                                  .decreaseQuantity(),
                                              index: index));
                                    }
                                  }),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(
                        height: AppSizes.spaceBtwVerticalFieldsTooLarge),
                    ButtonPrimary(
                        loading: state is ReturnRequestLoadingState,
                        text: AppText.requestReturnPageRequestReturn
                            .capitalizeEveryWord.get,
                        onTap: () {
                          final finalState = state.copyWith(products: state.products.where((e) => e.quantity > 0).toList());
                          final validationResult =
                              ReturnRequestValidation.validate(finalState);
                          if (validationResult.success) {
                            BlocProvider.of<ReturnDetailsBloc>(context)
                                .add(RequestReturnEvent());
                          } else {
                            dialogUtil.toast(validationResult.message);
                          }
                        }),
                    const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                  ]),
                )
              : FormInfoSkeleton(
                  image: AppImages.timeManagement,
                  message: AppText.infoRightOfWithdrawal(
                          FakeAppDefaults.defaultReturnDay)
                      .capitalizeFirstWord
                      .get),
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
