import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppSizes.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    primaryColorDark: AppColors.lightSecondary,
    scaffoldBackgroundColor: AppColors.lightPrimary,
    cardColor: AppColors.lightTertiaryColor,
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
    scaffoldBackgroundColor: AppColors.darkPrimary,
    cardColor: AppColors.darkTertiaryColor,
    textTheme: TextTheme(
      headlineMedium: AppStyles.titleMediumDark,
      bodyMedium: AppStyles.bodyMediumDark,
    ),
    cardTheme: const CardTheme(
      color: AppColors.darkTertiaryColor,
    ),
  );
}
