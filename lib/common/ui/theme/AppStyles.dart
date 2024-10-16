import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_up_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';

class AppStyles {
  static const grandisExtendedFont = "GrandisExtended";

  static final ElevatedButtonThemeData elevatedButtonThemeDataLight = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(AppSizes.defaultPadding),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      minimumSize: const Size(double.infinity, 32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
      ),
    ),
  );
  static final ElevatedButtonThemeData elevatedButtonThemeDataDark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(AppSizes.defaultPadding),
      backgroundColor: AppColors.primaryColorDark,
      foregroundColor: AppColors.whiteColor80,
      minimumSize: const Size(double.infinity, 32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
      ),
    ),
  );
  static const defaultNavigationBarThemeLight = BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.blackColor,
    selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
    unselectedIconTheme: IconThemeData(color: AppColors.blackColor),
    showUnselectedLabels: false,
  );
  static const defaultNavigationBarThemeDark = BottomNavigationBarThemeData(
    backgroundColor: AppColors.blackColor,
    selectedItemColor: AppColors.primaryColorDark,
    unselectedItemColor: AppColors.whiteColor80,
    selectedIconTheme: IconThemeData(color: AppColors.primaryColorDark),
    unselectedIconTheme: IconThemeData(color: AppColors.whiteColor40),
    showUnselectedLabels: false,
  );

  //todo: handle
  static const dialogThemeLight = DialogTheme(
    backgroundColor: AppColors.whiteColor,
  );
  static const dialogThemeDark = DialogTheme(
    backgroundColor: AppColors.blackColor,
  );

  static const chipThemeLight = ChipThemeData(
    brightness: Brightness.light,
    backgroundColor: AppColors.whiteColor,
    labelStyle: TextStyle(fontSize: 12, color: AppColors.blackColor),
    secondarySelectedColor: AppColors.whiteColor,
    secondaryLabelStyle: TextStyle(color: AppColors.cyanColor),
    side: BorderSide(
      color: AppColors.greyColor,
    ),
  );
  static const chipThemeDark = ChipThemeData(
    brightness: Brightness.dark,
    labelStyle: TextStyle(fontSize: 12, color: AppColors.greyColor),
    side: BorderSide(
      color: AppColors.greyColor,
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme({required bool isDarkMode}) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        overlayColor: AppColors.whiteColor20,
        foregroundColor:isDarkMode ? AppColors.whiteColor80 :  AppColors.blackColor80,
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        minimumSize: const Size(double.infinity, 32),
        side: BorderSide(width: 1, color:isDarkMode ? AppColors.whiteColor80 :  AppColors.blackColor40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
        ),
      ),
    );
  }

  //todo: handle
  static final textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.primaryColorDark),
  );

  static const InputDecorationTheme inputDecorationThemeLight = InputDecorationTheme(
    fillColor: AppColors.lightGreyColor,
    filled: true,
    border: AppStyles.outlineInputBorder,
    prefixIconColor: AppColors.greyColor,
    labelStyle: TextStyle(color: AppColors.greyColor),
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedOutlineInputBorder,
    errorBorder: errorOutlineInputBorder,
  );

  static const InputDecorationTheme inputDecorationThemeDark = InputDecorationTheme(
    fillColor: AppColors.darkGreyColor,
    filled: true,
    border: AppStyles.outlineInputBorder,
    prefixIconColor: AppColors.greyColor,
    labelStyle: TextStyle(color: AppColors.greyColor),
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedOutlineInputBorder,
    errorBorder: errorOutlineInputBorder,
  );

  //todo: handle
  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
    borderSide: BorderSide(color: AppColors.greyColor, width: AppSizes.defaultBoxWidth),
  );

  static const OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  static const OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
    borderSide: BorderSide(
      color: AppColors.errorColor,
    ),
  );

  static OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
      borderSide: BorderSide(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.15),
      ),
    );
  }

  static CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.defaultBorderRadius / 2),
      ),
    ),
    side: const BorderSide(color: AppColors.whiteColor40),
  );

  static const AppBarTheme appBarLightTheme = AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.blackColor),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor,
    ),
  );

  static AppBarTheme appBarDarkTheme = const AppBarTheme(
    backgroundColor: AppColors.blackColor,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.whiteColor80),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.whiteColor80,
    ),
  );

  //todo:
  static ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
    trackColor: WidgetStateProperty.all(AppColors.primaryColor),
  );

  static DataTableThemeData dataTableLightThemeData = DataTableThemeData(
    columnSpacing: 24,
    headingRowColor: WidgetStateProperty.all(Colors.black12),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
      border: Border.all(color: Colors.black12),
    ),
    dataTextStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor,
    ),
  );

  static DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
    columnSpacing: 24,
    headingRowColor: WidgetStateProperty.all(Colors.white10),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
      border: Border.all(color: Colors.white10),
    ),
    dataTextStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.whiteColor80,
      fontSize: 12,
    ),
  );

  static ButtonStyle _clickableWidgetOutlinedStyleLight({Size? minimumSize, Size? maximumSize}) =>
      OutlinedButton.styleFrom(
          minimumSize: minimumSize,
          maximumSize: maximumSize,
          overlayColor: AppColors.greyColor,
          disabledBackgroundColor: AppColors.whiteColor80,
          padding: const EdgeInsets.all(8));

  static ButtonStyle _clickableWidgetOutlinedStyleDark({Size? minimumSize, Size? maximumSize}) =>
      OutlinedButton.styleFrom(
          overlayColor: AppColors.greyColor,
          minimumSize: minimumSize,
          maximumSize: maximumSize,
          padding: const EdgeInsets.all(8));

  static ButtonStyle clickableWidgetOutlinedStyle(BuildContext context, {Size? minimumSize, Size? maximumSize}) =>
      context.isDarkMode
          ? _clickableWidgetOutlinedStyleDark(minimumSize: minimumSize, maximumSize: maximumSize)
          : _clickableWidgetOutlinedStyleLight(minimumSize: minimumSize, maximumSize: maximumSize);

  static BoxDecoration defaultBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
      border: Border.all(
        color: AppColors.greyColor,
        width: AppSizes.defaultBoxWidth,
      ));

  static FloatingActionButtonThemeData floatActionThemeLight = const FloatingActionButtonThemeData(
   backgroundColor: AppColors.primaryColor,
   foregroundColor: AppColors.whiteColor90
  );
  static FloatingActionButtonThemeData floatActionThemeDark = const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColorDark,
      foregroundColor: AppColors.whiteColor10
  );

/*

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


  static InputDecorationTheme inputDecorationLightTheme = InputDecorationTheme(
    fillColor: AppColors.hiddenGrey,
    filled: true,
    hintStyle: TextStyle(color: AppColors.grey),
    border: AppStyles.outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedOutlineInputBorder,
    errorBorder: errorOutlineInputBorder,
  );

  static InputDecorationTheme inputDecorationDarkTheme = InputDecorationTheme(
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
    borderSide: BorderSide(color: AppColors.blueColor),
  );

  static OutlineInputBorder errorOutlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultCornerRadius)),
    borderSide: BorderSide(
      color: AppColors.errorColor,
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
*/
}
