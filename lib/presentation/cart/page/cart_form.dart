import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/order_summary.dart';
import 'package:ecommerce_app_mobile/presentation/cart/page/paying_screen.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/secondary_prouduct_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:flutter/material.dart';

import '../../../data/model/user.dart';


class CartForm extends StatelessWidget {
  final User user;
  const CartForm({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: CustomScrollView(
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
                childCount: FakeProductModels.products.length,
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwVerticalFieldsSmall/2),
                  child: SecondaryProductCard(
                    product: FakeProductModels.products[index],
                  ),
                ),
              )),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.spaceBtwVerticalFields,),
              ),
              SliverToBoxAdapter(
                child: OrderSummaryCard(
                  product: FakeProductModels.product1,
                 date: DateTime.now().toString(),
                  amount: 100,
                  isReturn: false,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.spaceBtwVerticalFieldsLarge,),
              ),
              SliverToBoxAdapter(
                child: ButtonPrimary(text: AppText.commonContinue.capitalizeFirstWord,onTap:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PayingScreen(),));
                }),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.spaceBtwVerticalFields,),
              ),
            ],
          ),
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
