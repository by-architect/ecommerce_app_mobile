import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'banner_m.dart';


class BannerMStyle3 extends StatelessWidget {
  const BannerMStyle3({
    super.key,
    required this.image,
    required this.title,
    required this.press,
    required this.discountPercent,
  });
  final String image;
  final String title;
  final int discountPercent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultPadding / 2,
                          vertical: AppSizes.defaultPadding / 8),
                      color: Colors.white70,
                      child: Text(
                        "$discountPercent% off",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.defaultPadding / 2),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: AppStyles.grandisExtendedFont,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.defaultPadding),
              SizedBox(
                height: 48,
                width: 48,
                child: ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Arrow - Right.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
