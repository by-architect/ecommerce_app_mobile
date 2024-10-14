import 'dart:ui';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/color_util.dart';
import 'package:flutter/material.dart';

class ColorFilters {
  static ColorFilter pinkToPrimaryColor(BuildContext context) =>
      ColorUtil.changeColorOfSvg(
          AppColors.svgPicturePinkColor, Theme.of(context).primaryColor);

  static ColorFilter greyIconColorFilter(BuildContext context) =>
      ColorFilter.mode(
          Theme.of(context).iconTheme.color!.withOpacity(0.5), BlendMode.srcIn);

  static ColorFilter iconThemeColor(BuildContext context) => ColorFilter.mode(
      Theme.of(context).iconTheme.color ?? AppColors.blackColor,
      BlendMode.srcIn);

  static ColorFilter primaryIconColorFilter(BuildContext context) =>
      ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn);

  static ColorFilter get errorColorFilter =>
      const ColorFilter.mode(AppColors.errorColor, BlendMode.srcIn);

  static ColorFilter oneColorForIcon(Color color) => ColorFilter.mode(color, BlendMode.srcIn);
}
