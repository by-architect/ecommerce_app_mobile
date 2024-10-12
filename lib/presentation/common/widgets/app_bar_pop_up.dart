import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';

class AppBarPopUp extends StatefulWidget implements PreferredSizeWidget {

  final Function()? onCloseTap;
  const AppBarPopUp({super.key, this.onCloseTap,});

  @override
  State<AppBarPopUp> createState() => _AppBarPopUpState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarPopUpState extends State<AppBarPopUp> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    leading: const SizedBox(),
    leadingWidth: 0,
    titleSpacing: AppSizes.defaultPadding,
    centerTitle: false,
    title: const TextMarket(),
      actions: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwHorizontalFields),
          child: IconButton(
            onPressed: widget.onCloseTap ?? () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              AppImages.closeIcon,
              height: 24,
              colorFilter:ColorFilters.iconThemeColor(context)
            ),
          ),
        ),
      ],
    );
  }
}
