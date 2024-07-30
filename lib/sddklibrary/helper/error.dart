import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';

class DefaultError {
  final String userMessage;
  final String? exception;
  final String? errorCode;
  final StackTrace? stackTrace;
  final DateTime? dateTime = DateTime.now();

  DefaultError({
    required this.userMessage,
    this.exception,
    this.errorCode,
    this.stackTrace,
  }){

    Log.error(exception ?? "",title: "Default Error",userMessage: userMessage,stackTrace: stackTrace,);
  }
}
