import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    this.svgSrc,
    required this.title,
    this.isShowBottomBorder = false,
    required this.press, this.textStyle,
  });

  final String? svgSrc;
     final String title;
  final bool isShowBottomBorder;
  final VoidCallback press;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        ListTile(
          onTap: press,
          minLeadingWidth: 24,
          leading: svgSrc != null? SvgPicture.asset(
            svgSrc!,
            height: 24,
            colorFilter: ColorFilters.iconThemeColor(context),
          ):null,
          title: Text(title,style: textStyle,),
          trailing: SvgPicture.asset(
            AppImages.miniRightIcon,
            colorFilter: ColorFilters.iconThemeColor(context),
          ),
        ),
        if (isShowBottomBorder) const Divider(height: 1),
      ],
    );
  }
}
