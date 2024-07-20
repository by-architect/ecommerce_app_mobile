
import 'package:flutter/material.dart';

import '../../data/model/user.dart';

extension UIHelper on BuildContext {
  bool get isDarkMode {
    return Theme
        .of(this)
        .brightness == Brightness.dark;
  }

  T? pageData<T>(String navigatorArg) {
    try {
      final Map<String, dynamic>? args = ModalRoute
          .of(this)!
          .settings
          .arguments as Map<String, dynamic>?;
      if (args != null) throw Exception("Navigation arguments are empty");
      final data = args![navigatorArg] as T;
      return data; 
    }
    catch(e) {
      return null;
    }
  }
}
