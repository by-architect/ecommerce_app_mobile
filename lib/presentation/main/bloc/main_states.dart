import 'package:ecommerce_app_mobile/common/ui/theme/AppTheme.dart';
import 'package:flutter/material.dart';

import '../../../data/model/categories.dart';
import '../../../data/model/product_feature.dart';
import '../../../sddklibrary/util/fail.dart';

class MainStates {
  final ThemeMode themeMode;
  final Categories categories;
  final ProductFeatures features;

  MainStates({required this.themeMode, required this.features, required this.categories});
  MainStates copyWith({ThemeMode? themeMode,Categories? categories, ProductFeatures? productFeatures}){
   return MainStates(themeMode: themeMode ?? this.themeMode, features:productFeatures ?? features, categories: categories ?? this.categories) ;
  }
}

class InitMainStates extends MainStates {
  InitMainStates()
      : super(
            themeMode: ThemeMode.light,
            categories: Categories.empty(),
            features: ProductFeatures.empty());
}

class InitItemsLoadingState extends MainStates{
  InitItemsLoadingState({required super.themeMode, required super.features, required super.categories});

}
class InitItemsSuccessState extends MainStates{
  InitItemsSuccessState({required super.themeMode, required super.features, required super.categories});

}
class InitItemsFailState extends MainStates{
  final Fail fail;
  InitItemsFailState({required super.themeMode, required super.features, required super.categories,required this.fail});
}

