import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/discover/page/discover_form.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/search_widget.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:flutter/material.dart';

import '../../../data/model/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<Category>> categoriesByLayer = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const <Widget>[
              NavigationDestination(icon: Icon(Icons.home), label: AppText.navigationHome),
              NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: AppText.navigationDiscover),
              NavigationDestination(icon: Icon(Icons.shopping_cart), label: AppText.navigationCart),
              NavigationDestination(icon: Icon(Icons.person_2_outlined), label: AppText.navigationAccount),
            ],
          ),
          body: <Widget>[
            const Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [],
              ),
            ),
            const DiscoverForm(),
            // FailSkeleton(fail: Fail(userMessage: "network fail"),)
          ][selectedIndex]),
    );
  }
}
