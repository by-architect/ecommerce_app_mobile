import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_up_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/ui/theme/AppColors.dart';

class ClickableWidgetOutlined extends StatelessWidget {
  const ClickableWidgetOutlined({super.key, this.onPressed, required this.child, this.shape, this.style, this.minimumSize, this.maximumSize});

  final Function()? onPressed;
  final Widget child;
  final OutlinedBorder? shape;
  final ButtonStyle? style;
  final Size? minimumSize;
  final Size? maximumSize;


  ///for no padding
  /// style: AppStyles.clickableWidgetOutlinedStyleNoPadding(context),

  @override
  Widget build(BuildContext context) {
    return style == null
        ? OutlinedButton(
            onPressed: onPressed,
            style: AppStyles.clickableWidgetOutlinedStyle(context,
                minimumSize:minimumSize, maximumSize: maximumSize),
        // minimumSize: Size(256, 114), maximumSize: Size(256, 114)),
            child: child,
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: child,
          );
  }
}
