import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/app_bar_default.dart';
import 'package:ecommerce_app_mobile/presentation/cart/page/cart_form.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../discover/bloc/discover_bloc.dart';
import '../../discover/bloc/discover_event.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<MainBlocs>(context).add(GetInitItemsEvent());
    BlocProvider.of<HomeBloc>(context).add(GetProductsHomeEvent());
    BlocProvider.of<SearchBloc>(context).add(GetRecentSearchesEvent());
    BlocProvider.of<MainBlocs>(context).stream.listen(
      (state) {
        if (state is InitItemsSuccessState) {
          BlocProvider.of<DiscoverBloc>(context).add(GetCategoriesDiscoverEvent(state.categories));
        }
        if (state is! InitItemsLoadingState) {
          FlutterNativeSplash.remove();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocs, MainStates>(
        builder: (BuildContext context, MainStates state) => switch (state) {
/*
              InitItemsLoadingState _ => const Scaffold(
                    body: Padding(
                  padding: EdgeInsets.all(AppSizes.defaultSpace),
                  child: Center(child: DiscoverCategoriesSkeleton()),
                )),
*/
              InitItemsFailState failState => Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.defaultSpace),
                      child: FailForm(
                        fail: failState.fail,
                        onRefreshTap: () {
                          BlocProvider.of<MainBlocs>(context).add(GetInitItemsEvent());
                          BlocProvider.of<HomeBloc>(context).add(GetProductsHomeEvent());
                          BlocProvider.of<SearchBloc>(context).add(GetRecentSearchesEvent());
                        },
                      ),
                    ),
                  ),
                ),
              InitItemsSuccessState _ => SafeArea(
                    child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBarMain(
                    user: state.userStatus.user,
                    features: state.features,
                    categories: state.categories,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: selectedIndex,
                    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                    onTap: (int index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: AppText.navigationHome.capitalizeFirstWord,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.grid_view_rounded),
                        label: AppText.navigationDiscover.capitalizeFirstWord,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.shopping_cart),
                        label: AppText.navigationCart.capitalizeFirstWord,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.person_2_outlined),
                        label: AppText.navigationAccount.capitalizeFirstWord,
                      ),
                    ],
                  ),
                  body: <Widget>[
                    HomeForm(
                      productFeatures: state.features,
                      categories: state.categories,
                    ),
                    DiscoverForm(
                      categories: state.categories,
                      features: state.features,
                    ),
                    state.userStatus.isAuthenticated
                        ? CartForm(
                            user: state.userStatus.user!,
                          )
                        : LoginForm(
                            message: AppText.infoPleaseLoginToSeeYourCart.capitalizeFirstWord,
                            image: AppImages.cartImage),
                    state.userStatus.isAuthenticated
                        ? ProfileForm(
                            user: state.userStatus.user!,
                          )
                        : LoginForm(
                            message: AppText.infoPleaseLoginToSeeYourCart.capitalizeFirstWord,
                            image: AppImages.profileImage)
                    // FailSkeleton(fail: Fail(userMessage: "network fail"),)
                  ][selectedIndex],
                )),
              _ => const SizedBox.shrink(),
            });
  }
}
