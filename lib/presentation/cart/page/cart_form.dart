import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/email_verification_screen.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_event.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/order_summary.dart';
import 'package:ecommerce_app_mobile/presentation/cart/page/paying_screen.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app_mobile/presentation/common/screen/loading_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_card_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/skelton.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/offers_skeleton.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';

class CartForm extends StatefulWidget {
  final User user;

  const CartForm({super.key, required this.user});

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
                      BlocProvider.of<CartBloc>(context).add(GetCart(widget.user));
                    },
                  ),
                CartSuccessState _ || CartState _ => state.items.isNotEmpty
                    ? CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Text(
                              AppText.cartPageReviewYourOrder.capitalizeEveryWord,
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
                              padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwVerticalFieldsSmall / 2),
                              child: CartItemWidget(
                                  numOfItem: state.items[index].quantity,
                                  onIncrement: () {
                                    CartItem cartItem = state.items[index];
                                    if (cartItem.quantity == FakeAppDefaults.maxQuantityOfProduct ||
                                        cartItem.quantity == cartItem.subProduct.quantity) {
                                    } else if (cartItem.quantity > FakeAppDefaults.maxQuantityOfProduct) {
                                      //todo: fake app defaults max quantity kısmını serverdan çek
                                      BlocProvider.of<CartBloc>(context).add(ChangeCartItem(
                                        cartItem: cartItem.copyWith(quantity: FakeAppDefaults.maxQuantityOfProduct),
                                        user: widget.user,
                                      ));
                                    } else if (cartItem.quantity > cartItem.subProduct.quantity) {
                                      BlocProvider.of<CartBloc>(context).add(ChangeCartItem(
                                          cartItem: cartItem.copyWith(
                                            quantity: cartItem.subProduct.quantity,
                                          ),
                                          user: widget.user));
                                    } else {
                                      BlocProvider.of<CartBloc>(context).add(
                                          ChangeCartItem(cartItem: cartItem.increaseQuantity(), user: widget.user));
                                    }
                                  },
                                  onDecrement: () {
                                    CartItem cartItem = state.items[index];
                                    if (cartItem.quantity > 0) {
                                      BlocProvider.of<CartBloc>(context).add(
                                        ChangeCartItem(cartItem: cartItem.decreaseQuantity(), user: widget.user),
                                      );
                                    }
                                  },
                                  cartItem: state.items[index]),
                            ),
                          )),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppSizes.spaceBtwVerticalFields,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: OrderSummaryCard(
                              discount: state.discount,
                              shippingFee: state.shippingFee,
                              subtotal: state.subTotal,
                              total: state.total,
                              isReturn: false,
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: AppSizes.spaceBtwVerticalFieldsLarge,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ButtonPrimary(
                                text: AppText.commonContinue.capitalizeFirstWord,
                                onTap: () {
                                  if (!widget.user.firebaseUser.emailVerified) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EmailVerificationScreen(user: widget.user),
                                    ));
                                  } else if (false /*todo: check to address before buy screen*/) {
                                    //todo: add address screen
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const PayingScreen(),
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
                          message: AppText.infoEmptyCart.capitalizeEveryWord,
                        ),
                      ),
              }),
        ),
      ),
    );
  }
}

/*
SafeArea(
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
child: CustomScrollView(
slivers: [
SliverPadding(
padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultPadding),
sliver: SliverToBoxAdapter(
child: WalletBalanceCard(
balance: 384.90,
onTabChargeBalance: () {},
),
),
),
SliverPadding(
padding: const EdgeInsets.only(top: AppSizes.defaultPadding / 2),
sliver: SliverToBoxAdapter(
child: Text(
"Wallet history",
style: Theme.of(context).textTheme.titleSmall,
),
),
),
SliverList(
delegate: SliverChildBuilderDelegate(
(context, index) => Padding(
padding: const EdgeInsets.only(top: AppSizes.defaultPadding),
child: WalletHistoryCard(
isReturn: index == 1,
date: "JUN 12, 2020",
amount: 129,
products: FakeProductModels.products,
),
),
childCount: 4,
),
)
],
),
),
)*/
