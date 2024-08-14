import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';

class RowItemDefault extends StatelessWidget {
  final Widget text;
  final Widget? firstIcon;
  final Widget? lastIcon;
  final Function() onTap;

  const RowItemDefault({super.key, required this.text,  required this.onTap, this.firstIcon, this.lastIcon});

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onPressed: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    firstIcon ?? const SizedBox.shrink(),
                    const SizedBox(
                      width: AppSizes.spaceBtwHorizontalFields,
                    ),
                    text
                  ],
                ),
                if(lastIcon!= null)
                  lastIcon!
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
