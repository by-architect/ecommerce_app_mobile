import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/material.dart';

class ProductReturnsScreen extends StatelessWidget {
  final String returnText;

  const ProductReturnsScreen({super.key, required this.returnText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(title: AppText.productDetailsPageReturn.capitalizeFirstWord.get,),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.defaultPadding),
/*
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    AppText.productDetailsPageReturn,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
*/
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultPadding),
              child: Text(returnText),
            )
          ],
        ),
      ),
    );
  }
}
