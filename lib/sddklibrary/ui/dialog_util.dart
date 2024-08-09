import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  final BuildContext _context;
  bool _showingADialog = false;

  DialogUtil(this._context);

  void toast(String message, {int duration = 3}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    );

    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  void alert(String title, String content, String positiveButtonText, String negativeButtonText, Function() onClick) {
    if(!_showingADialog) {
      _showingADialog = true;
      showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onClick();
                _showingADialog = false;
                Navigator.of(context).pop();
              },
              child: Text(positiveButtonText),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(negativeButtonText),
            ),
          ],
        );
      },
    );
    }
  }

  void info(String title, String content) {
    if(!_showingADialog) {
      _showingADialog = true;
      showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _showingADialog = false;
                Navigator.of(context).pop();
              },
              child: const Text(AppText.dismiss),
            ),
          ],
        );
      },
    );
    }
  }

  void loading() {
    if (_showingADialog) return;
    _showingADialog = true;
    showDialog(
        barrierDismissible: false,
        context: _context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text(AppText.loading),
            actions: <Widget>[Center(child: CircularProgressIndicator())],
          );
        });
  }

  void closeLoadingDialog() {
    if (!_showingADialog) return;
    Navigator.pop(_context);
    _showingADialog = false;
  }
}
