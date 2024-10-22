import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/AppSizes.dart';

/*
class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.last4Digits,
    required this.name,
    required this.expiryDate,
    this.isSelected = false,
    this.press,
    this.bgColor = AppColors.primaryColor,
  });

  final String last4Digits, name, expiryDate;
  final bool isSelected;
  final VoidCallback? press;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.defaultBorderRadius * 2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/card.svg",
                                height: 32,
                                width: 32,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                              if (isSelected)
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        AppSizes.defaultPadding / 4),
                                    child: SvgPicture.asset(
                                      "assets/icons/Singlecheck.svg",
                                      colorFilter: const ColorFilter.mode(
                                          AppColors.primaryColor, BlendMode.srcIn),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            "**** **** **** $last4Digits",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: AppSizes.defaultPadding),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Card_Pattern.svg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.defaultPadding),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name),
                                const SizedBox(height: AppSizes.defaultPadding / 4),
                                Text(expiryDate)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected) const SizedBox(height: AppSizes.defaultPadding),
          if (isSelected)
            Form(
              child: TextFormField(
                validator: (value) {
                  return null;
                },
                onSaved: (cvv) {},
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: "CVV",
                  counterText: "",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.defaultPadding * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/CVV.svg",
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .inputDecorationTheme
                              .hintStyle!
                              .color!,
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          if (isSelected) const SizedBox(height: AppSizes.defaultPadding / 2),
        ],
      ),
    );
  }
}*/
