import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppText.dart';

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
    centerTitle: false,
    title: Text(AppText.marketName,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.blackColor,fontWeight:  FontWeight.bold,fontStyle: FontStyle.italic),),
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
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
