import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CheckMark extends StatelessWidget {
  const CheckMark({
    super.key,
    this.radius = 8,
     this.activeColor,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(2),
  });
  final double radius;
  final Color? activeColor;
  final Color  iconColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 8,
      backgroundColor: activeColor ?? Theme.of(context).primaryColor,
      child: Padding(
        padding: padding,
        child: SvgPicture.asset(
          AppImages.singleCheckIcon,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
