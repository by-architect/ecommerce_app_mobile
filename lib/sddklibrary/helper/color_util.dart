
import 'dart:ui';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';

class ColorUtil{

  static ColorFilter changeColorOfSvg(Color originalColor,Color replacementColor){
    Color originalColor = const Color(0x006c63ff);
    Color replacementColor = AppColors.primaryColor;

    final or = originalColor.red / 255;
    final og = originalColor.green / 255;
    final ob = originalColor.blue / 255;
    final nr = replacementColor.red / 255;
    final ng = replacementColor.green / 255;
    final nb = replacementColor.blue / 255;

    // Create the color matrix
    final List<double> matrix = [
      or == 0 ? 0 : nr / or, 0, 0, 0, 0,
      0, og == 0 ? 0 : ng / og, 0, 0, 0,
      0, 0, ob == 0 ? 0 : nb / ob, 0, 0,
      0, 0, 0, 1, 0,
    ];

    return ColorFilter.matrix(matrix);
  }
}