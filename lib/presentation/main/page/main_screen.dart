import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/app_bar_default.dart';
import 'package:ecommerce_app_mobile/presentation/cart/page/cart_form.dart';
import 'package:ecommerce_app_mobile/presentation/common/screen/loading_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/discover/page/discover_form.dart';
import 'package:ecommerce_app_mobile/presentation/home/form/home_form.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:ecommerce_app_mobile/presentation/main/form/login_form.dart';
import 'package:ecommerce_app_mobile/presentation/profile/page/profile_form.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_event.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    BlocProvider.of<MainBlocs>(context).add(GetInitItemsEvent());
    BlocProvider.of<HomeBloc>(context).add(GetProductsHomeEvent());
    BlocProvider.of<SearchBloc>(context).add(GetRecentSearchesEvent());
    BlocProvider.of<MainBlocs>(context).stream.listen(
      (state) {
        if(pageController.hasClients) {
          pageController.jumpToPage(state.selectedPage);
        }
        if (state is InitItemsSuccessState) {
          if (state.userStatus.isAuthenticated) {
            BlocProvider.of<CartBloc>(context).add(GetCart(
                state.userStatus.user!, state.appSettings.defaultShippingFee));
          }
        }
        if (state is! InitItemsLoadingState) {
          FlutterNativeSplash.remove();
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocs, MainStates>(
        builder: (BuildContext context, MainStates state) => switch (state) {
              InitItemsLoadingState _ => const Scaffold(body: LoadingScreen()),
              InitItemsFailState failState => Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.defaultSpace),
                      child: FailForm(
                        fail: failState.fail,
                        onRefreshTap: () {
                          BlocProvider.of<MainBlocs>(context)
                              .add(GetInitItemsEvent());
                          BlocProvider.of<HomeBloc>(context)
                              .add(GetProductsHomeEvent());
                          BlocProvider.of<SearchBloc>(context)
                              .add(GetRecentSearchesEvent());
                        },
                      ),
                    ),
                  ),
                ),
              InitItemsSuccessState _ || MainStates() => SafeArea(
                    child: Scaffold(
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
                )),
            });
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
