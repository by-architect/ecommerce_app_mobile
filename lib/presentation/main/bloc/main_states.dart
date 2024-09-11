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

  MainStates(
      {required this.userStatus, required this.themeMode, required this.features, required this.categories});

  MainStates copyWith({ThemeMode? themeMode, Categories? categories, AllProductFeatures? productFeatures,UserStatus? userStatus}) {
    return MainStates(
        themeMode: themeMode ?? this.themeMode,
        features: productFeatures ?? features,
        categories: categories ?? this.categories,
        userStatus: userStatus ?? this.userStatus);
  }
}

class InitMainStates extends MainStates {
  InitMainStates()
      : super(
            userStatus: UserStatus(null),
            themeMode: ThemeMode.light,
            categories: Categories.empty(),
            features: AllProductFeatures.empty());
}

class InitItemsLoadingState extends MainStates {
  InitItemsLoadingState({required super.themeMode, required super.features, required super.categories, required super.userStatus});
}

class InitItemsSuccessState extends MainStates {
  InitItemsSuccessState({required super.themeMode, required super.features, required super.categories, required super.userStatus});
}

class InitItemsFailState extends MainStates {
  final Fail fail;

  InitItemsFailState(
      {required super.themeMode,
      required super.features,
      required super.categories,
      required this.fail, required super.userStatus});
}
