import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/material.dart';

class MainEvents{}

class ToggleThemeEvent extends MainEvents{
  late ThemeMode themeMode;


  ToggleThemeEvent(BuildContext context){
   themeMode = context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
  
  ToggleThemeEvent.from(this.themeMode);
  
}


class GetInitItemsEvent extends MainEvents{}
class UserSignedInEvent extends MainEvents{
  final User user;

  UserSignedInEvent(this.user);
}
class GetUserIfAuthorizedEvent extends MainEvents{}
class UserIsVerifiedEvent extends MainEvents{
  final User user;

  UserIsVerifiedEvent(this.user);
}
class LogOutEvent extends MainEvents{}
