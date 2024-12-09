import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';

class ButtonSecondary extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final Widget? child;
  final bool isLoading;

  const ButtonSecondary({
    this.text,
    this.isLoading = false,
    this.onTap,
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: isLoading ? () {} : onTap,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(context.isDarkMode
                      ? AppColors.whiteColor
                      : AppColors.blackColor),
                ),
              )
            : child ??
                Text(
                  text ?? "",
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
