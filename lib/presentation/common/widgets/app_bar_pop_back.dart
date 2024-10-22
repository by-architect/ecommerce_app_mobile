import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';

class AppBarPopBack extends StatefulWidget implements PreferredSizeWidget {
  const AppBarPopBack({
    super.key,
    this.title,
    this.icon,
    this.iconTap,
    this.iconColor,
  });

  final String? title;
  final String? icon;
  final Color? iconColor;
  final Function()? iconTap;

  @override
  State<AppBarPopBack> createState() => _AppBarPopBackState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarPopBackState extends State<AppBarPopBack> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: const Padding(
        padding: EdgeInsets.only(left: AppSizes.defaultPadding, top: AppSizes.defaultPadding),
        child: BackButton(),
      ),
      centerTitle: true,
      actions: [
        if (widget.icon != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
              child: ClickableWidget(
                shape: const CircleBorder(),
                onPressed: widget.iconTap ?? () {},
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    widget.icon!,
                    colorFilter: widget.iconColor == null
                        ? ColorFilters.iconThemeColor(context)
                        : ColorFilters.oneColorForIcon(widget.iconColor!),
                  ),
                ),
              ),
            ),
          )
      ],
      title: Padding(
        padding: const EdgeInsets.only(top: AppSizes.defaultPadding),
        child: Text(
          widget.title ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
