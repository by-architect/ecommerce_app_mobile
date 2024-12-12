import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:flutter/material.dart';

import '../util/fail.dart';

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

  void toastWithButton(String message, String buttonText, Function() onPressed) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: buttonText,
        onPressed: onPressed,
      ),
    );

    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  void showFullScreen(BuildContext context, {String? message, Fail? fail, Function()? onTapRefresh}) {
    if (!_showingADialog) {
      _showingADialog = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => FullscreenLoadingDialog(
          message: message,
          fail: fail,
          onTapRefresh: onTapRefresh,
        ),
      );
    }
  }

  void alert(String title, String content, String positiveButtonText, String negativeButtonText, Function() onClick) {
    if (!_showingADialog) {
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

  void inputDialog({required String title, required String content, required Function(String) onAccept, Function()? onCancel}) {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: _context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextFieldDefault(
          onChanged: (data) {},
          labelOrHint: content,
          controller: textController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              onCancel?.call();
              Navigator.of(context).pop();
            },
            child: Text(AppText.cancel.capitalizeFirstWord.get),
          ),
          TextButton(
            onPressed: () {
              onAccept(textController.text);
              Navigator.of(context).pop(textController.text);
            },
            child: Text(AppText.done.capitalizeFirstWord.get),
          ),
        ],
      ),
    );
  }

  void info(String title, String content) {
    if (!_showingADialog) {
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
                child: Text(AppText.dismiss.capitalizeFirstWord.get),
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
          return AlertDialog(
            title: Text(AppText.loading.capitalizeFirstWord.get),
            actions: const <Widget>[Center(child: CircularProgressIndicator())],
          );
        });
  }

  void closeLoadingDialog() {
    if (!_showingADialog) return;
    Navigator.pop(_context);
    _showingADialog = false;
  }
}

class FullscreenLoadingDialog extends StatelessWidget {
  final String? message;
  final Fail? fail;
  final Function()? onTapRefresh;

  const FullscreenLoadingDialog({super.key, this.message, this.fail, this.onTapRefresh});

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: fail == null
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        message ?? AppText.loading.capitalizeFirstWord.get,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : FailForm(fail: fail!, onRefreshTap: onTapRefresh ?? () {}),
        ),
      ),
    );
  }
}
