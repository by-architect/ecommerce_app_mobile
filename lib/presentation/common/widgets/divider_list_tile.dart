import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/color_filters.dart';

class DividerListTile extends StatelessWidget {
  const DividerListTile({
    super.key,
    this.isShowForwardArrow = true,
    required this.title,
    required this.press,
    this.leading,
    this.minLeadingWidth,
    this.isShowDivider = true, this.subTitle,
  });
  final bool isShowForwardArrow, isShowDivider;
  final Widget title;
  final Widget? leading;
  final double? minLeadingWidth;
  final VoidCallback press;
  final Widget? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minLeadingWidth: minLeadingWidth,
          leading: leading,
          onTap: press,
          title: title,
          subtitle: subTitle,
          trailing: isShowForwardArrow
              ? SvgPicture.asset(
            AppImages.miniRightIcon,
            colorFilter: ColorFilters.greyIconColorFilter(context),
          )
              : null,
        ),
        if (isShowDivider) const Divider(height: 1),
      ],
    );
  }
}

class DividerListTileWithTrailingText extends StatelessWidget {
  const DividerListTileWithTrailingText({
    super.key,
    required this.svgSrc,
    required this.title,
    required this.trilingText,
    required this.press,
    this.isShowArrow = true,
  });

  final String svgSrc, title, trilingText;
  final VoidCallback press;
  final bool isShowArrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          minLeadingWidth: 24,
          leading: SvgPicture.asset(
            svgSrc,
            height: 24,
            width: 24,
            colorFilter: ColorFilters.iconThemeColor(context),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, height: 1),
          ),
          trailing: SizedBox(
            width: 50,
            child: Row(
              children: [
                const Spacer(),
                Text(trilingText),
                SvgPicture.asset(
                  AppImages.miniRightIcon,
                  colorFilter: ColorFilters.iconThemeColor(context),
                ),
              ],
            ),
          ),
        ),
        if (isShowArrow) const Divider(height: 1),
      ],
    );
  }
}