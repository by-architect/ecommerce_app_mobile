import 'package:ecommerce_app_mobile/sddklibrary/helper/UIHelper.dart';
import 'package:flutter/material.dart';

class MainEvents{}

class ToggleThemeEvent extends MainEvents{
  late ThemeMode themeMode;


  ToggleThemeEvent(BuildContext context){
   themeMode = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
  
  ToggleThemeEvent.from(this.themeMode);
  
}