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
        onPressed: loading ? (){} : onTap,
        child: loading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.isDarkMode ? AppColors.blackColor : AppColors.whiteColor),
                ),
              )
            : Text(
                text,
              ));
  }
}
