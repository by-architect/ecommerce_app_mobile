import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BannerDiscountTag extends StatelessWidget {
  const BannerDiscountTag({
    super.key,
    this.width = 36,
    this.height = 60,
    required this.percentage,
    this.percentageFontSize = 10,
  });
  final double width, height;
  final int percentage;
  final double percentageFontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppImages.discountTagIcon,
            fit: BoxFit.fill,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          Text(
            "$percentage%\n${AppText.commonPageOff}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStyles.grandisExtendedFont,
              color: Colors.black54,
              fontSize: percentageFontSize,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
