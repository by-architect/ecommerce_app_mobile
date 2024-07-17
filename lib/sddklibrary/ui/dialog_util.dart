import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static void alertDialog() {}

  static void toast(BuildContext context, String message, {int duration = 3}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
