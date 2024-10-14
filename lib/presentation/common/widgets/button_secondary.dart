import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';

class ButtonSecondary extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final Widget? child;

  const ButtonSecondary({
    this.text,
    this.onTap,
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onTap,
        child: child ??
            Text(
              text??"",
            ));
  }

/*
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: AppSizes.buttonHeight,
        decoration: primaryDecoration
            ? AppStyles.buttonContainerDecorationPrimary(context)
            : AppStyles.buttonContainerDecorationSecondary(context),
        child: Center(
          child: loading // Check if loading is true
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryDecoration ? Colors.white : Colors.black),
                )
              : Text(
                  text,
                  style: TextStyle(color: primaryDecoration ? Colors.white : Colors.black.withOpacity(0.7)),
                ),
        ),
      ),
    );
  }
*/
}
