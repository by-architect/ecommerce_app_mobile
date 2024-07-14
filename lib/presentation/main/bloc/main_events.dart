import 'package:ecommerce_app_mobile/common/helper/Log.dart';
import 'package:ecommerce_app_mobile/common/helper/UIHelper.dart';
import 'package:flutter/material.dart';

class MainEvents{}

class ToggleTheme extends MainEvents{
  late ThemeMode themeMode;


  ToggleTheme(BuildContext context){
   themeMode = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
  
  ToggleTheme.from(ThemeMode themeMode){
    themeMode = themeMode;
  }
  
}