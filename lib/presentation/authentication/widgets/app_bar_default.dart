import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../search/bloc/search_bloc.dart';
import '../../search/bloc/search_event.dart';
class AppBarMain extends StatelessWidget implements PreferredSizeWidget{
  const AppBarMain({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    leading: const SizedBox(),
    leadingWidth: 0,
    centerTitle: false,
    title: Text(AppText.marketName,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.blackColor,fontWeight:  FontWeight.bold,fontStyle: FontStyle.italic),),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Screens.searchScreen);
          },
          icon: SvgPicture.asset(
            AppImages.searchIcon,
            height: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!,
                BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Screens.notificationScreen);
          },
          icon: SvgPicture.asset(
            AppImages.notificationIcon,
            height: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!,
                BlendMode.srcIn),
          ),
        ),
      ],
      /*SvgPicture.asset(
    "assets/logo/Shoplon.svg",
    colorFilter: ColorFilter.mode(
    Theme.of(context).iconTheme.color!, BlendMode.srcIn),
    height: 20,
    width: 100,
    )*/
    );
  }

}
