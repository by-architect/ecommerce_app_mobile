import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
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

class MainForm extends StatelessWidget {
  const MainForm({super.key, required this.state, required this.pageController});
  final MainStates state;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          children: [
                            HomeForm(
                              appSettings: state.appSettings,
                              user: state.userStatus.user,
                              productFeatures: state.features,
                              categories: state.categories,
                            ),
                            DiscoverForm(
                              appSettings: state.appSettings,
                              user: state.userStatus.user,
                              categories: state.categories,
                              features: state.features,
                            ),
                            state.userStatus.isAuthenticated
                                ? CartForm(
                                    appSettings: state.appSettings,
                                    user: state.userStatus.user!,
                                  )
                                : LoginForm(
                                    message: AppText
                                        .infoPleaseLoginToSeeYourCart
                                        .capitalizeFirstWord
                                        .get,
                                    image: AppImages.cartImage),
                            state.userStatus.isAuthenticated
                                ? ProfileForm(
                                    appSettings: state.appSettings,
                                    user: state.userStatus.user!,
                                  )
                                : LoginForm(
                                    message: AppText
                                        .infoPleaseLoginToSeeYourProfile
                                        .capitalizeFirstWord
                                        .get,
                                    image: AppImages.profileImage),
                            // FailSkeleton(fail: Fail(userMessage: "network fail"),)
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor),
                        height: 68,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _NavBarItem(
                              icon: AppImages.shopIcon,
                              isSelected: state.selectedPage == 0,
                              onClicked: () {
                                BlocProvider.of<MainBlocs>(context)
                                    .add(ChangePageEvent(0));
                              },
                            ),
                            _NavBarItem(
                              icon: AppImages.categoryIcon,
                              isSelected: state.selectedPage == 1,
                              onClicked: () {
                                BlocProvider.of<MainBlocs>(context)
                                    .add(ChangePageEvent(1));
                              },
                            ),
                            _NavBarItem(
                              icon: AppImages.cartIcon,
                              isSelected: state.selectedPage == 2,
                              onClicked: () {
                                BlocProvider.of<MainBlocs>(context)
                                    .add(ChangePageEvent(2));
                              },
                            ),
                            _NavBarItem(
                              icon: AppImages.profileIcon,
                              isSelected: state.selectedPage == 3,
                              onClicked: () {
                                BlocProvider.of<MainBlocs>(context)
                                    .add(ChangePageEvent(3));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  resizeToAvoidBottomInset: false,
                  appBar: AppBarMain(
                    appSettings: state.appSettings,
                    user: state.userStatus.user,
                    features: state.features,
                    categories: state.categories,
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
