import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/main/page/main_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main/bloc/main_blocs.dart';

class AddedToCartMessageScreen extends StatelessWidget {
  const AddedToCartMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
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
                AppText.productDetailsPageAddedToCart.capitalizeEveryWord.get,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppSizes.defaultPadding / 2),
              Text(
                AppText.productDetailsPageAddedToCart.capitalizeFirstWord.get,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              ButtonSecondary(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: AppText
                    .productDetailsPageContinueShopping.capitalizeEveryWord.get,
              ),
              const SizedBox(height: AppSizes.defaultPadding),
              ButtonPrimary(
                onTap: () {
                  BlocProvider.of<MainBlocs>(context).add(ChangePageEvent(2));
                  Navigator.of(context).popUntil((S) => S.isFirst);
                },
                text:
                    AppText.productDetailsPageCheckout.capitalizeFirstWord.get,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
