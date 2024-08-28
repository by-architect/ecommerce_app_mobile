import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/app_bar_default.dart';
import 'package:ecommerce_app_mobile/presentation/cart/page/cart_form.dart';
import 'package:ecommerce_app_mobile/presentation/discover/page/discover_form.dart';
import 'package:ecommerce_app_mobile/presentation/home/form/home_form.dart';
import 'package:ecommerce_app_mobile/presentation/profile/page/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/category.dart';
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
    BlocProvider.of<HomeBloc>(context).add(GetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const AppBarMain(),
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
                icon: Icon(Icons.home),
                label: AppText.navigationHome.capitalizeFirstWord,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: AppText.navigationDiscover.capitalizeFirstWord,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: AppText.navigationCart.capitalizeFirstWord,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: AppText.navigationAccount.capitalizeFirstWord,
              ),
            ],
          ),
          body: <Widget>[
            const HomeForm(),
            const DiscoverForm(),
            const CartForm(),
            const ProfileForm()
            // FailSkeleton(fail: Fail(userMessage: "network fail"),)
          ][selectedIndex],
    ));
  }
}
