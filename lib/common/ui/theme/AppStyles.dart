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


  //decoration
  static BoxDecoration buttonContainerDecorationPrimary(BuildContext context) =>
      BoxDecoration(
        color: Theme
            .of(context)
            .primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      );

  static BoxDecoration buttonContainerDecorationSecondary(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      );
}
