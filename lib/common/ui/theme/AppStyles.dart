import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';

class AppStyles {
//light
  static const TextStyle titleMediumLight = TextStyle(
      fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.lightPrimary);

  static TextStyle bodyMediumLight = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.grey);



  //dark
  static const TextStyle titleMediumDark = TextStyle(
      fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.darkPrimary);
  static TextStyle bodyMediumDark = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.grey);

}
