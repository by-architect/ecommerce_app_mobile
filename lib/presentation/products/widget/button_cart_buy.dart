import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';

class ButtonCartBuy extends StatelessWidget {
  const ButtonCartBuy({
    super.key,
    required this.price,
    this.title,
    this.subTitle,
    required this.press,
  });

  final double price;
  final String? title;

  final String? subTitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultBorderRadius / 2),
        child: SizedBox(
          height: 64,
          child: Material(
            color: Theme.of(context).primaryColor,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSizes.defaultBorderRadius),
              ),
            ),
            child: InkWell(
              onTap: press,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${price.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                          ),
                          Text(
                            subTitle ?? AppText.productPageUnitPrice.capitalizeEveryWord,
                            style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.15),
                      child: Text(
                        title ?? AppText.productPageBuyNow.capitalizeEveryWord,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
