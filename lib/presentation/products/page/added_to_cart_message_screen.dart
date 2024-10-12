import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/presentation/main/page/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddedToCartMessageScreen extends StatelessWidget {
  const AddedToCartMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset(
                AppImages.successfulPurchase,
                height: MediaQuery.of(context).size.height * 0.3,
                colorFilter: ColorFilters.pinkToPrimaryColor(context),
              ),
              const Spacer(flex: 2),
              Text(
                AppText.productDetailsPageAddedToCart.capitalizeEveryWord,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppSizes.defaultPadding / 2),
              Text(
                AppText.productDetailsPageAddedToCart.capitalizeFirstWord,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppText.productDetailsPageContinueShopping.capitalizeEveryWord),
              ),
              const SizedBox(height: AppSizes.defaultPadding),
              ElevatedButton(
                onPressed: () {
                  //todo: go to cart
                },
                child: Text(AppText.productDetailsPageCheckout.capitalizeFirstWord),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
