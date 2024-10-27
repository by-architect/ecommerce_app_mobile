import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Light Colors
/*
  static const Color lightPrimary = Color.fromARGB(255, 9, 4, 70);
  static const Color lightSecondary = Color.fromARGB(255, 228, 91, 39);
  static const Color lightBackground = Color.fromARGB(255, 255, 255, 255);
  static const Color lightTertiaryColor = Color.fromARGB(255, 211, 135, 53);

  // Dark Colors
  static const Color darkPrimary = Color.fromARGB(255, 243, 23, 2);
  static const Color darkSecondary = Color.fromARGB(255, 218, 194, 125);
  static const Color darkBackground = Color.fromARGB(255, 0, 0, 0);
  static const Color darkTertiaryColor = Color.fromARGB(255, 192, 18, 2);
*/

  // Additional Color
  // static const Color additionalColor = Color.fromARGB(255, 220, 160, 95);
  // static const Color complementaryColor = Color.fromARGB(255, 148, 147, 217);
  // static Color grey = Colors.grey.withOpacity(1);
  // static Color hiddenGrey = Colors.grey.withOpacity(0.5);
  // static Color hiddenBlack = Colors.black.withOpacity(0.8);
  static const Color linkColor = Color.fromARGB(255, 0, 0, 238);

  static const Color blackColor = Color(0xFF16161E);
  static const Color blackColor80 = Color(0xFF45454B);
  static const Color blackColor60 = Color(0xFF737378);
  static const Color blackColor40 = Color(0xFFA2A2A5);
  static const Color blackColor20 = Color(0xFFD0D0D2);
  static const Color blackColor10 = Color(0xFFE8E8E9);
  static const Color blackColor5 = Color(0xFFF3F3F4);

  static const Color whiteColor = Colors.white;
  static const Color whiteColor90 = Color(0xFFDCDADA);
  static const Color whiteColor80 = Color(0xFFCCCCCC);
  static const Color whiteColor60 = Color(0xFF999999);
  static const Color whiteColor40 = Color(0xFF666666);
  static const Color whiteColor20 = Color(0xFF333333);
  static const Color whiteColor10 = Color(0xFF191919);
  static const Color whiteColor5 = Color(0xFF0D0D0D);

  static const Color greyColor = Color(0xFFB8B5C3);
  static const Color lightGreyColor = Color(0xFFF8F8F9);
  static const Color darkGreyColor = Color(0xFF1C1C25);

// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

  static const Color purpleColor = Color(0xFF7B61FF);
  static const Color cyanColor = Colors.cyan;
  static const Color successColor = Color(0xFF2ED573);
  static const Color warningColor = Color(0xFFFFBE21);
  static const Color errorColor = Color(0xFFEA5B5B);

  //App colors
  static const Color blueColorDark = Color.fromARGB(255, 9, 4, 70);

  static const Color yellowColorLight = Color(0xFFC08552);
  static const Color yellowColorDark = Color(0xFF8F552A);

  static const primaryColor = AppColors.yellowColorLight;
  static const primaryColorDark = AppColors.yellowColorDark;

  static const MaterialColor blueMaterialColorDark = MaterialColor(
    0xFF090446, // Use the original color as the primary key
    <int, Color>{
      50: Color(0xFFE1E0E9),
      100: Color(0xFFB5B3C8),
      200: Color(0xFF8481A4),
      300: Color(0xFF534F80),
      400: Color(0xFF2E2A65),
      500: Color(0xFF090446), // Your original color
      600: Color(0xFF08033F),
      700: Color(0xFF060237),
      800: Color(0xFF05022F),
      900: Color(0xFF030120),
    },
  );

  // Theme.of(context).primaryColor.asMaterialColor.shade900
  static const MaterialColor yellowMaterialColorDark = MaterialColor(
    0xFF8F552A,
    <int, Color>{
      50: Color(0xFF3A2D27), // Darker lightest shade
      100: Color(0xFF5B4B3C), // Darker light shade
      200: Color(0xFF7D6A54), // Slightly darker
      300: Color(0xFF9F886B), // Mid-tone dark
      400: Color(0xFFBFA283), // Darker mid-tone
      500: Color(0xFFC08552), // Your original color
      600: Color(0xFFB77D4B), // Darker variant
      700: Color(0xFFAC7242), // Darker variant
      800: Color(0xFFA1683A), // Darker variant
      900: Color(0xFF8F552A), // Darker variant
    },
  );

  static const MaterialColor yellowMaterialColorLight = MaterialColor(
    0xFFC08552,
    <int, Color>{
      50: Color(0xFFF3E7DF),
      100: Color(0xFFE0C5B4),
      200: Color(0xFFCC9F84),
      300: Color(0xFFB77954),
      400: Color(0xFFA95F33),
      500: Color(0xFFC08552), // Your original color
      600: Color(0xFFB77D4B),
      700: Color(0xFFAC7242),
      800: Color(0xFFA1683A),
      900: Color(0xFF8F552A),
    },
  );

  //Svg picture original colors
  static const Color svgPicturePinkColor = Color(0x006C63FF);
}
