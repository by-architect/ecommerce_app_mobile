import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/user_status.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/user.dart';
import '../../common/widgets/divider_list_tile.dart';
import '../../common/widgets/network_image_with_loader.dart';
import '../widget/profile_card.dart';
import '../widget/profile_menu_item_list.dart';

class ProfileForm extends StatelessWidget {
  final User user;

  const ProfileForm({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileCard(
            name: "Sepide",
            email: "theflutterway@gmail.com",
            imageSrc: "https://i.imgur.com/IXnwbLk.png",
            // proLableText: "Sliver",
            // isPro: true, if the user is pro

            press: () {
              // Navigator.pushNamed(context, );
            },
          ),
/*
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding * 1.5),
            child: GestureDetector(
              onTap: () {},
              child: const AspectRatio(
                aspectRatio: 1.8,
                child:
                NetworkImageWithLoader("https://i.imgur.com/dz0BBom.png"),
              ),
            ),
          ),
*/

          const SizedBox(height: AppSizes.defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
            child: Text(
              AppText.profilePageMarketing.capitalizeFirstWord,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: AppSizes.defaultPadding / 2),
          ProfileMenuListTile(
            text: AppText.profilePageOrders.capitalizeFirstWord,
            svgSrc: AppImages.orderIcon,
            press: () {
              // Navigator.pushNamed(context, ordersScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: AppText.productDetailsPageReturns.capitalizeFirstWord,
            svgSrc: AppImages.returnIcon,
            press: () {},
          ),
          ProfileMenuListTile(
            text: AppText.profilePageAddresses.capitalizeFirstWord,
            svgSrc: AppImages.addressIcon,
            press: () {
              // Navigator.pushNamed(context, addressesScreenRoute);
            },
          ),
          const SizedBox(height: AppSizes.defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
            child: Text(
              AppText.account.capitalizeFirstWord,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: AppText.profilePageChangePassword.capitalizeEveryWord,
            svgSrc: AppImages.passwordIcon,
            press: () {
              // Navigator.pushNamed(context, selectLanguageScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: AppText.profilePageEditProfile.capitalizeEveryWord,
            svgSrc: AppImages.profileIcon,
            press: () {},
          ),
          const SizedBox(height: AppSizes.defaultPadding),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
            child: Text(
              AppText.profilePageHelpAndSupport.capitalizeEveryWord,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: AppText.profilePageGetHelp.capitalizeEveryWord,
            svgSrc: AppImages.helpIcon,
            press: () {
              // Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: AppText.profilePageFAQ.capitalizeFirstWord,
            svgSrc: AppImages.fAQIcon,
            press: () {},
            isShowDivider: false,
          ),
          const SizedBox(height: AppSizes.defaultPadding),
          // Log Out
          ListTile(
            onTap: () {
              BlocProvider.of<MainBlocs>(context).add(LogOutEvent());
            },
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              AppImages.logoutIcon,
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.errorColor,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              AppText.logOut.capitalizeEveryWord,
              style: const TextStyle(color: AppColors.errorColor, fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}
