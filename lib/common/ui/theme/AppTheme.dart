import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTheme {
  get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.yellowMaterialColorLight,
      fontFamily: "PlusJakarta",
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: AppStyles.floatActionThemeLight,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.blackColor40)),
      elevatedButtonTheme: AppStyles.elevatedButtonThemeDataLight,
      textButtonTheme: AppStyles.textButtonThemeData,
      outlinedButtonTheme: AppStyles.outlinedButtonTheme(isDarkMode: false),
      inputDecorationTheme: AppStyles.inputDecorationThemeLight,
      dialogTheme: AppStyles.dialogThemeLight,
      checkboxTheme: AppStyles.checkboxThemeData.copyWith(side: const BorderSide(color: AppColors.blackColor40)),
      bottomNavigationBarTheme: AppStyles.defaultNavigationBarThemeLight,
      appBarTheme: AppStyles.appBarLightTheme,
      bottomSheetTheme: AppStyles.defaultBottomSheetThemeLight,
      chipTheme: AppStyles.chipThemeLight,
      scrollbarTheme: AppStyles.scrollbarThemeData,
      dataTableTheme: AppStyles.dataTableLightThemeData);

  get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.yellowMaterialColorDark,
      primarySwatch: AppColors.yellowMaterialColorDark,
      fontFamily: "PlusJakarta",
      floatingActionButtonTheme: AppStyles.floatActionThemeDark,
      scaffoldBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.whiteColor80),
        bodySmall: TextStyle(color: AppColors.whiteColor80),
        bodyLarge: TextStyle(color: AppColors.whiteColor80),
        labelMedium: TextStyle(color: AppColors.whiteColor80),
        labelSmall: TextStyle(color: AppColors.whiteColor80),
        labelLarge: TextStyle(color: AppColors.whiteColor80),
      ),
      elevatedButtonTheme: AppStyles.elevatedButtonThemeDataDark,
      textButtonTheme: AppStyles.textButtonThemeData,
      outlinedButtonTheme: AppStyles.outlinedButtonTheme(isDarkMode: true),
      bottomSheetTheme: AppStyles.defaultBottomSheetThemeDark,
      inputDecorationTheme: AppStyles.inputDecorationThemeDark,
      checkboxTheme: AppStyles.checkboxThemeData.copyWith(side: const BorderSide(color: AppColors.whiteColor40)),
      bottomNavigationBarTheme: AppStyles.defaultNavigationBarThemeDark,
      appBarTheme: AppStyles.appBarDarkTheme,
      chipTheme: AppStyles.chipThemeDark,
      scrollbarTheme: AppStyles.scrollbarThemeData,
      dataTableTheme: AppStyles.dataTableDarkThemeData);
}

extension ColorExtention on Color {
  MaterialColor get asMaterialColor =>
      this is MaterialColor ? this as MaterialColor : MaterialColor(value, const <int, Color>{});
}
