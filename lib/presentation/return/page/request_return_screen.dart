import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/product_card_large.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/widget/text_field_explanation.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppText.dart';

class RequestReturnScreen extends StatefulWidget {
  const RequestReturnScreen(
      {super.key, required this.orderModel, required this.user});

  final OrderModel orderModel;
  final User user;

  @override
  State<RequestReturnScreen> createState() => _RequestReturnScreenState();
}

class _RequestReturnScreenState extends State<RequestReturnScreen> {
  @override
  void initState() {
    final productBaseList = widget.orderModel.products.toList();
    productBaseList.forEach((element) => element = element.setQuantity(0));
    BlocProvider.of<ReturnDetailsBloc>(context)
        .add(InitialProductsEvent(products: productBaseList));
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.spaceBtwVerticalFieldsSmall / 2),
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
                                          color: Theme.of(context).primaryColor)
                                  : null,
                            ),
                          ),
                        ),
                      );
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
                    ...List.generate(widget.orderModel.products.length,
                        (index) {
                      return Placeholder();
                      return CartItemWidget(
                        cartItem: CartItem(
                            productWithQuantity:
                                widget.orderModel.products[index],
                            id: index.toString()),
                        onIncrement: () {
                          BlocProvider.of<ReturnDetailsBloc>(context).add(
                              SelectedProductEvent(
                                  product:
                                      state.products[index].increaseQuantity(),
                                  index: index));
                        },
                        onDecrement: () {
                          BlocProvider.of<ReturnDetailsBloc>(context).add(
                              SelectedProductEvent(
                                  product:
                                      state.products[index].decreaseQuantity(),
                                  index: index));
                        },
                        numOfItem: state.products[index].quantity,
                      );
                    })
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
