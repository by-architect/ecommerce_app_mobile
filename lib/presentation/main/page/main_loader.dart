import 'package:ecommerce_app_mobile/presentation/common/screen/app_locked_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/screen/loading_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/screen/update_required_screen.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:ecommerce_app_mobile/presentation/main/form/main_fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/main/form/main_form.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_event.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';
import '../../splash/pages/welcome_screen.dart';

class MainLoader extends StatefulWidget {
  const MainLoader({super.key});

  @override
  State<MainLoader> createState() => _MainLoaderState();
}

class _MainLoaderState extends State<MainLoader> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    BlocProvider.of<MainBlocs>(context).add(GetInitItemsEvent());
    BlocProvider.of<HomeBloc>(context).add(GetProductsHomeEvent());
    BlocProvider.of<MainBlocs>(context).stream.listen(
      (state) {
        if (!mounted) {
          return;
        }
        Log.test(title: "main state", data: state);
        if (pageController.hasClients) {
          pageController.jumpToPage(state.selectedPage);
        }
        if (state is MainScreenState) {
          if (state.userStatus.isAuthenticated) {
            BlocProvider.of<CartBloc>(context).add(GetCart(state.userStatus.user!, state.appSettings.defaultShippingFee));
            BlocProvider.of<SearchBloc>(context).add(GetRecentSearchesEvent(state.userStatus.user!.uid));
          }
        }
        if (state is! MainLoadingState) {
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
        builder: (BuildContext context, MainStates state) => SafeArea(
              child: switch (state) {
                MainLoadingState _ => const Scaffold(body: LoadingScreen()),
                MainLoadFailState failState => MainFailForm(
                    failState: failState,
                    user: state.userStatus.user,
                  ),
                WelcomeScreenState _ => const WelcomeScreen(),
                UpdateScreenState _ => UpdateRequiredScreen(
                    forceUpdate: state.appSettings.forceUpdate,
                  ),
                AppIsGettingReadyState _ => const AppLockedScreen(),
                MainScreenState _ || MainStates() => MainForm(
                    state: state,
                    pageController: pageController,
                  ),
              },
            ));
  }
}
