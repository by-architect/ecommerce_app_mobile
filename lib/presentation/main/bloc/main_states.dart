import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/user_status.dart';
import 'package:flutter/material.dart';

import '../../../data/model/categories.dart';
import '../../../data/model/product_feature.dart';
import '../../../sddklibrary/util/fail.dart';

class MainStates {
  final ThemeMode themeMode;
  final Categories categories;
  final AllProductFeatures features;
  final UserStatus userStatus;
  final AppSettings appSettings;
  final int selectedPage;

  MainStates(
      {required this.appSettings,
      required this.userStatus,
        required this.selectedPage,
      required this.themeMode,
      required this.features,
      required this.categories});

  MainStates copyWith(
      {ThemeMode? themeMode,
      Categories? categories,
      AllProductFeatures? productFeatures,
        AppSettings? appSettings,
        int? selectedPage,
      UserStatus? userStatus}) {
    return MainStates(
        themeMode: themeMode ?? this.themeMode,
        features: productFeatures ?? features,
        categories: categories ?? this.categories,
        selectedPage: selectedPage ?? this.selectedPage,
        appSettings: appSettings ?? this.appSettings,
        userStatus: userStatus ?? this.userStatus);
  }
}

class InitMainStates extends MainStates {
  InitMainStates()
      : super(
            userStatus: UserStatus(null),
            themeMode: ThemeMode.light,
            categories: Categories.empty(),
            selectedPage: 0,
            appSettings: AppSettings.defaultAppSettings(),
            features: AllProductFeatures.empty());
}

class InitItemsLoadingState extends MainStates {
  final MainStates state;

  InitItemsLoadingState({required this.state})
      : super(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            selectedPage: state.selectedPage,
            appSettings: state.appSettings,
            userStatus: state.userStatus);
}

class InitItemsSuccessState extends MainStates {
  final MainStates state;

  InitItemsSuccessState({required this.state})
      : super(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            selectedPage: state.selectedPage,
            appSettings: state.appSettings,
            userStatus: state.userStatus);
}

class InitItemsFailState extends MainStates {
  final Fail fail;
  final MainStates state;

  InitItemsFailState({required this.fail, required this.state})
      : super(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            selectedPage: state.selectedPage,
            appSettings: state.appSettings,
            userStatus: state.userStatus);
}
