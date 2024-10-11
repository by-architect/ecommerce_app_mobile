import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTheme {
  get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.blueColorLight,
      primarySwatch: AppColors.blueMaterialColorLight,
      fontFamily: "PlusJakarta",
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.blackColor40)),
      elevatedButtonTheme: AppStyles.elevatedButtonThemeDataLight,
      textButtonTheme: AppStyles.textButtonThemeData,
      outlinedButtonTheme: AppStyles.outlinedButtonTheme(),
      inputDecorationTheme: AppStyles.lightInputDecorationTheme,
      dialogTheme: AppStyles.dialogLightTheme,
      checkboxTheme: AppStyles.checkboxThemeData.copyWith(side: const BorderSide(color: AppColors.blackColor40)),
      bottomNavigationBarTheme: AppStyles.defaultNavigationBarThemeLight,
      appBarTheme: AppStyles.appBarLightTheme,
      chipTheme:AppStyles.chipThemeLight ,
      scrollbarTheme: AppStyles.scrollbarThemeData,
      dataTableTheme: AppStyles.dataTableLightThemeData);

  get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.blueColorDark,
      primarySwatch: AppColors.blueMaterialColorDark,
      fontFamily: "PlusJakarta",
      scaffoldBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.whiteColor40)),
      elevatedButtonTheme: AppStyles.elevatedButtonThemeDataDark,
      textButtonTheme: AppStyles.textButtonThemeData,
      outlinedButtonTheme: AppStyles.outlinedButtonTheme(),
      inputDecorationTheme: AppStyles.darkInputDecorationTheme,
      checkboxTheme: AppStyles.checkboxThemeData.copyWith(side: const BorderSide(color: AppColors.whiteColor40)),
      bottomNavigationBarTheme: AppStyles.defaultNavigationBarThemeDark,
      appBarTheme: AppStyles.appBarDarkTheme,
      chipTheme:AppStyles.chipThemeDark ,
      scrollbarTheme: AppStyles.scrollbarThemeData,
      dataTableTheme: AppStyles.dataTableDarkThemeData);
}
