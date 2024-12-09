import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/email_verification_screen.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_event.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/order_summary.dart';
import 'package:ecommerce_app_mobile/presentation/cart/page/payment_screen.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app_mobile/presentation/common/screen/loading_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';

class CartForm extends StatefulWidget {
  final User user;
  final AppSettings appSettings;

  const CartForm({super.key, required this.user, required this.appSettings});

  @override
  State<CartForm> createState() => _CartFormState();
}

class _CartFormState extends State<CartForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, CartState state) => Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultPadding),
              child: switch (state) {
                CartLoadingState _ => const LoadingScreen(),
                CartFailState failState => FailForm(
                    fail: failState.fail,
                    onRefreshTap: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(GetCart(widget.user,widget.appSettings.defaultShippingFee));
                    },
                  ),
                CartSuccessState _ || CartState _ => state.items.isNotEmpty
                    ? CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Text(
                              AppText.cartPageReviewYourOrder
                                  .capitalizeEveryWord.get,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppSizes.spaceBtwVerticalFields,
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                            childCount: state.items.length,
                            (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      AppSizes.spaceBtwVerticalFieldsSmall / 2),
                              child: CartItemWidget.fromCartItem(
                                cartItem: state.items[index],
                                onIncrement: () {
                                  CartItem cartItem = state.items[index];
                                  if (cartItem.productWithQuantity.quantity ==
                                         widget.appSettings
                                              .maxProductQuantityCustomerCanBuyInOrder ||
                                      cartItem.productWithQuantity.quantity ==
                                          cartItem.productWithQuantity
                                              .subProduct.quantity) {
                                  } else if (cartItem
                                          .productWithQuantity.quantity >
                                     widget
                                          .appSettings.maxProductQuantityCustomerCanBuyInOrder) {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(ChangeCartItem(
                                      defaultShippingFee: widget.appSettings.defaultShippingFee,
                                      cartItem: cartItem.copyWith(
                                          quantity: widget.appSettings
                                              .maxProductQuantityCustomerCanBuyInOrder),
                                      user: widget.user,
                                    ));
                                  } else if (cartItem
                                          .productWithQuantity.quantity >
                                      cartItem.productWithQuantity.subProduct
                                          .quantity) {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(ChangeCartItem(
                                            defaultShippingFee: widget.appSettings.defaultShippingFee,
                                            cartItem: cartItem.copyWith(
                                              quantity: cartItem
                                                  .productWithQuantity
                                                  .subProduct
                                                  .quantity,
                                            ),
                                            user: widget.user));
                                  } else {
                                    BlocProvider.of<CartBloc>(context).add(
                                        ChangeCartItem(
                                            defaultShippingFee: widget.appSettings.defaultShippingFee,
                                            cartItem:
                                                cartItem.increaseQuantity(),
                                            user: widget.user));
                                  }
                                },
                                onDecrement: () {
                                  CartItem cartItem = state.items[index];
                                  if (cartItem.productWithQuantity.quantity >
                                      0) {
                                    BlocProvider.of<CartBloc>(context).add(
                                      ChangeCartItem(
                                          defaultShippingFee: widget.appSettings.defaultShippingFee,
                                          cartItem: cartItem.decreaseQuantity(),
                                          user: widget.user),
                                    );
                                  }
                                },
                              ),
                            ),
                          )),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppSizes.spaceBtwVerticalFields,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: OrderSummaryCard(
                              purchaseSummary: state.purchaseSummary,
                              isReturn: false, currency: widget.appSettings.defaultCurrency,
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppSizes.spaceBtwVerticalFieldsLarge,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ButtonPrimary(
                                text: AppText
                                    .commonContinue.capitalizeFirstWord.get,
                                onTap: () {
                                  if (!widget.user.firebaseUser.emailVerified) {
                                    DialogUtil(context).toast(
                                        AppText.errorEmailNotVerified.get);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          EmailVerificationScreen(
                                              user: widget.user),
                                    ));
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                        appSettings: widget.appSettings,
                                        user: widget.user,
                                      ),
                                    ));
                                  }
                                }),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppSizes.spaceBtwVerticalFields,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(24),
                        child: FormInfoSkeleton(
                          image: AppImages.cartImage,
                          message:
                              AppText.infoEmptyCart.capitalizeEveryWord.get,
                        ),
                      ),
              }),
        ),
      ),
    );
  }
}
