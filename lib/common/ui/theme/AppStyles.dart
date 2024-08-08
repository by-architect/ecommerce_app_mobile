import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';

class AppStyles {
//light
  static const TextStyle titleMediumLight = TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.lightPrimary);

  static TextStyle bodyMediumLight = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.grey);

  //dark
  static const TextStyle titleMediumDark = TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.darkPrimary);
  static TextStyle bodyMediumDark = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.grey);

  //decoration
  static BoxDecoration buttonContainerDecorationPrimary(BuildContext context) => BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      );

  static BoxDecoration buttonContainerDecorationSecondary(BuildContext context) => BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      );

  static InputDecoration defaultInputDecoration(BuildContext context, IconData icon, String label) => InputDecoration(
        prefixIcon: Icon(icon),
        prefixIconColor: AppColors.hiddenGrey,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.hiddenGrey,
            // Change this to your desired color
            width: AppSizes.defaultBoxWidth,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            // Change this to your desired color
            width: AppSizes.defaultBoxWidth,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
        ),
      );

  static BoxDecoration defaultBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(AppSizes.defaultCornerRadius),
          border: Border.all(

        color: AppColors.hiddenGrey,
        width: AppSizes.defaultBoxWidth,
      ));

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.hiddenGrey,
    filled: true,
    hintStyle: TextStyle(color: AppColors.grey),
    border: AppStyles.outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedOutlineInputBorder,
    errorBorder: errorOutlineInputBorder,
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.hiddenBlack,
    filled: true,
    hintStyle: const TextStyle(color: Colors.white),
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedOutlineInputBorder,
    errorBorder: errorOutlineInputBorder,
  );

  static OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  static OutlineInputBorder focusedOutlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
    borderSide: BorderSide(color: AppColors.lightPrimary),
  );

  static OutlineInputBorder errorOutlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );

  static OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
      borderSide: BorderSide(
        color: AppColors.hiddenGrey,
      ),
    );
  }
}
