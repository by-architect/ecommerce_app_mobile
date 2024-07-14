import 'package:ecommerce_app_mobile/common/ui/theme/AppTheme.dart';
import 'package:flutter/material.dart';

class MainStates {
  ThemeMode themeMode;

  MainStates({required this.themeMode});
}

class InitMainStates extends MainStates {
  InitMainStates() : super(themeMode: ThemeMode.light);
}
