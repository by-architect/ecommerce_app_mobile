import 'dart:async';

import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../common/ui/theme/color_filters.dart';
import '../../../sddklibrary/ui/widget_clickable.dart';
import '../../authentication/widgets/app_bar_default.dart';
import '../../cart/page/cart_form.dart';
import '../../discover/page/discover_form.dart';
import '../../home/form/home_form.dart';
import '../../profile/page/profile_form.dart';
import '../bloc/main_blocs.dart';
import '../bloc/main_events.dart';
import 'login_form.dart';

class MainForm extends StatefulWidget {
  const MainForm(
      {super.key, required this.state, required this.pageController});

  final MainStates state;
  final PageController pageController;

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  @override
  void initState() {
    BlocProvider.of<MainBlocs>(context).stream.listen((state) {
      Log.test(title: "Test", data: state.selectedPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: widget.pageController,
              children: [
                HomeForm(
                  appSettings: widget.state.appSettings,
                  user: widget.state.userStatus.user,
                  productFeatures: widget.state.features,
                  categories: widget.state.categories,
                ),
                DiscoverForm(
                  appSettings: widget.state.appSettings,
                  user: widget.state.userStatus.user,
                  categories: widget.state.categories,
                  features: widget.state.features,
                ),
                widget.state.userStatus.isAuthenticated
                    ? CartForm(
                        appSettings: widget.state.appSettings,
                        user: widget.state.userStatus.user!,
                      )
                    : LoginForm(
                        message: AppText.infoPleaseLoginToSeeYourCart
                            .capitalizeFirstWord.get,
                        image: AppImages.cartImage),
                widget.state.userStatus.isAuthenticated
                    ? ProfileForm(
                        appSettings: widget.state.appSettings,
                        user: widget.state.userStatus.user!,
                        themeMode: widget.state.themeMode,
                      )
                    : LoginForm(
                        message: AppText.infoPleaseLoginToSeeYourProfile
                            .capitalizeFirstWord.get,
                        image: AppImages.profileImage),
                // FailSkeleton(fail: Fail(userMessage: "network fail"),)
              ],
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            height: 68,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: AppImages.shopIcon,
                  isSelected: widget.state.selectedPage == 0,
                  onClicked: () {
                    BlocProvider.of<MainBlocs>(context).add(ChangePageEvent(0));
                  },
                ),
                _NavBarItem(
                  icon: AppImages.categoryIcon,
                  isSelected: widget.state.selectedPage == 1,
                  onClicked: () {
                    BlocProvider.of<MainBlocs>(context).add(ChangePageEvent(1));
                  },
                ),
                _NavBarItem(
                  icon: AppImages.cartIcon,
                  isSelected: widget.state.selectedPage == 2,
                  onClicked: () {
                    BlocProvider.of<MainBlocs>(context).add(ChangePageEvent(2));
                  },
                ),
                _NavBarItem(
                  icon: AppImages.profileIcon,
                  isSelected: widget.state.selectedPage == 3,
                  onClicked: () {
                    BlocProvider.of<MainBlocs>(context).add(ChangePageEvent(3));
                  },
                ),
              ],
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBarMain(
        appSettings: widget.state.appSettings,
        user: widget.state.userStatus.user,
        features: widget.state.features,
        categories: widget.state.categories,
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String icon;
  final Function() onClicked;
  final bool isSelected;

  const _NavBarItem(
      {super.key,
      required this.icon,
      required this.onClicked,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onPressed: onClicked,
      shape: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(
          width: 27,
          height: 27,
          icon,
          colorFilter: isSelected
              ? ColorFilters.primaryIconColorFilter(context)
              : ColorFilters.iconThemeColor(context),
        ),
      ),
    );
  }
}
