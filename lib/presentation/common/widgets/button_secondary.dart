import 'package:ecommerce_app_mobile/sddklibrary/helper/UIHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';

class ButtonSecondary extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const ButtonSecondary({
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: context.isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
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
