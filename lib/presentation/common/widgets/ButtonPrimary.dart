import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final bool primaryDecoration;
  final bool loading; // New loading variable
  final Function()? onTap;

  const ButtonPrimary({
    required this.text,
    this.primaryDecoration = true,
    this.loading = false, // Default value for loading
    this.onTap,
    super.key,
  });

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
}
