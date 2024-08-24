import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';

import 'check_mark.dart';


class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    required this.color,
    this.isActive = false,
    this.press,
  });
  final Color color;
  final bool isActive;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedContainer(
        duration: AppDurations.defaultDuration,
        padding: EdgeInsets.all(isActive ? AppSizes.defaultPadding / 4 : 0),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              Border.all(color: isActive ? AppColors.primaryColor : Colors.transparent),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
            ),
            AnimatedOpacity(
              opacity: isActive ? 1 : 0,
              duration: AppDurations.defaultDuration,
              child: const CheckMark(),
            ),
          ],
        ),
      ),
    );
  }
}
