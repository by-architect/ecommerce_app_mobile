import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';

class Fail {
  final String userMessage;
  final Object? exception;
  final String? errorCode;
  final StackTrace? stackTrace;
  final DateTime? dateTime = DateTime.now();

  Fail({
    required this.userMessage,
    this.exception,
    this.errorCode,
    this.stackTrace,
  }){

    Log.error(error: this,title: "Fail");
  }
}
