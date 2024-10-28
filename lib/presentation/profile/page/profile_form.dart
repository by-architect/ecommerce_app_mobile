import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/email_verification_screen.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/profile/page/change_password_screen.dart';
import 'package:ecommerce_app_mobile/presentation/profile/page/edit_profile_screen.dart';
import 'package:ecommerce_app_mobile/presentation/profile/widget/verify_email_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constant/Screens.dart';
import '../../../data/model/user.dart';
import '../../address/pages/addresses_screen.dart';
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
            name: user.name,
            email: user.email,
            imageSrc: user.firebaseUser.photoURL,
            // proLableText: "Sliver",
            // isPro: true, if the user is pro

            press: () {
              // Navigator.pushNamed(context, );
            },
          ),

          if (!user.firebaseUser.emailVerified)
            VerifyEmailCard(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EmailVerificationScreen(user: user),
                ));
              },
            ),


          const SizedBox(height: AppSizes.defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
            child: Text(
              AppText.profilePageMarketing.capitalizeFirstWord.get,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: AppSizes.defaultPadding / 2),
          ProfileMenuListTile(
            text: AppText.profilePageOrders.capitalizeFirstWord.get,
            svgSrc: AppImages.orderIcon,
            press: () {
              // Navigator.pushNamed(context, ordersScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: AppText.productDetailsPageReturns.capitalizeFirstWord.get,
            svgSrc: AppImages.returnIcon,
            press: () {},
          ),
          ProfileMenuListTile(
            text: AppText.profilePageAddresses.capitalizeFirstWord.get,
            svgSrc: AppImages.addressIcon,
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddressesScreen(user: user),
              ));
            },
          ),
          const SizedBox(height: AppSizes.defaultPadding),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
            child: Text(
              AppText.account.capitalizeFirstWord.get,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: AppText.profilePageChangePassword.capitalizeEveryWord.get,
            svgSrc: AppImages.passwordIcon,
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangePasswordScreen(
                  user: user,
                ),
              ));
            },
          ),
          ProfileMenuListTile(
            text: AppText.profilePageEditProfile.capitalizeEveryWord.get,
            svgSrc: AppImages.profileIcon,
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  user: user,
                ),
              ));
            },
          ),
          const SizedBox(height: AppSizes.defaultPadding),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
            child: Text(
              AppText.profilePageHelpAndSupport.capitalizeEveryWord.get,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: AppText.profilePageGetHelp.capitalizeEveryWord.get,
            svgSrc: AppImages.helpIcon,
            press: () {
              // Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: AppText.profilePageFAQ.capitalizeFirstWord.get,
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
              colorFilter: ColorFilters.errorColorFilter,
            ),
            title: Text(
              AppText.logOut.capitalizeEveryWord.get,
              style: const TextStyle(color: AppColors.errorColor, fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}
