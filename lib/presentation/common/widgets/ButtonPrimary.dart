import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final bool loading;
  final Function()? onTap;

  const ButtonPrimary({
    required this.text,
    this.loading = false,
   required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(context.isDarkMode ? AppColors.blackColor : AppColors.whiteColor),
              )
            : Text(text,));
  }

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
