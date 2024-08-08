import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    primaryColorDark: AppColors.lightSecondary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightTertiaryColor,
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      indicatorColor: AppColors.lightPrimary,
      elevation: AppSizes.defaultCornerRadius
    ),
    textTheme: TextTheme(
      headlineMedium: AppStyles.titleMediumLight,
      bodyMedium: AppStyles.bodyMediumLight,
    ),
    cardTheme: const CardTheme(
      color: AppColors.lightTertiaryColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    primaryColorDark: AppColors.darkSecondary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkTertiaryColor,
    navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: AppColors.darkPrimary,
        elevation: AppSizes.defaultCornerRadius
    ), //todo: handle navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue
    ),
    textTheme: TextTheme(
      headlineMedium: AppStyles.titleMediumDark,
      bodyMedium: AppStyles.bodyMediumDark,
    ),
    cardTheme: const CardTheme(
      color: AppColors.darkTertiaryColor,
    ),
  );
}
