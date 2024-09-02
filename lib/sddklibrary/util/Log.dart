import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum LogLevel { TEST, INFO, WARNING, ERROR }

enum _TextColor {
  RED,
  GREEN,
  YELLOW,
  BLUE,
  MAGENTA,
  CYAN,
  WHITE,
  BRIGHT_RED,
  BRIGHT_GREEN,
  BRIGHT_YELLOW,
  BRIGHT_BLUE,
  BRIGHT_MAGENTA,
  BRIGHT_CYAN,
  BRIGHT_WHITE,
  BOLD,
  ITALIC,
  UNDERLINE
}

class Log {
  static const String _reset = "\x1B[0m";
  static const String _red = "\x1B[31m";
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _blue = "\x1B[34m";
  static const String _magenta = "\x1B[35m";
  static const String _cyan = "\x1B[36m";
  static const String _white = "\x1B[37m";
  static const String _brightRed = "\x1B[91m";
  static const String _brightGreen = "\x1B[92m";
  static const String _brightYellow = "\x1B[93m";
  static const String _brightBlue = "\x1B[94m";
  static const String _brightMagenta = "\x1B[95m";
  static const String _brightCyan = "\x1B[96m";
  static const String _brightWhite = "\x1B[97m";
  static const String _bold = "\x1B[1m";
  static const String _italic = "\x1B[3m";
  static const String _underline = "\x1B[4m";

  static void log(LogLevel logLevel,
      {String? message,
      String title = "",
      String? userMessage,
      StackTrace? stackTrace,
      Object? data,
      Resource? resource}) {
    final timestamp = _getCurrentTime();

    final titleMessage = title.isEmpty ? "${logLevel.name}" : "${logLevel.name} -> $title";

    final colored = switch (logLevel) {
      LogLevel.TEST => _TextColor.BRIGHT_GREEN,
      LogLevel.INFO => _TextColor.BRIGHT_BLUE,
      LogLevel.WARNING => _TextColor.YELLOW,
      LogLevel.ERROR => _TextColor.RED
    };

    if (kReleaseMode) {
      // send logs to server
    } else {
      //debug mode
      debugPrint(_getColoredMessage(titleMessage, colored));
      if (message != null) debugPrint("---->  ${_getColoredMessage("Message: $message", colored)}");
      if (data != null)
        debugPrint("---->  ${_getColoredMessage("Data: $data", _TextColor.BRIGHT_CYAN)}");
      if (userMessage != null)
        debugPrint("---->  ${_getColoredMessage("User Message: $userMessage", _TextColor.MAGENTA)}");
      if (stackTrace != null) {
        final lastTrace = stackTrace.toString().split('\n').first;
        debugPrint(
            "---->  ${_getColoredMessage("Stack Trace: ${lastTrace.toString()}", _TextColor.BRIGHT_MAGENTA)}");
      }
/*
      if(resource!= null){
        debugPrint("---->  ${_getColoredMessage("Status: ${resource.status}", _TextColor.BRIGHT_CYAN)}");
        debugPrint("---->  ${_getColoredMessage("Data: ${resource.data}", _TextColor.GREEN)}");
        debugPrint("---->  ${_getColoredMessage("Fail: ${resource.error}", _TextColor.RED)}");
      }
*/
    }
  }

  static String _getColoredMessage(String message, _TextColor color) {
    switch (color) {
      case _TextColor.RED:
        return "$_red$message$_reset";
      case _TextColor.GREEN:
        return "$_green$message$_reset";
      case _TextColor.YELLOW:
        return "$_yellow$message$_reset";
      case _TextColor.BLUE:
        return "$_blue$message$_reset";
      case _TextColor.MAGENTA:
        return "$_magenta$message$_reset";
      case _TextColor.CYAN:
        return "$_cyan$message$_reset";
      case _TextColor.WHITE:
        return "$_white$message$_reset";
      case _TextColor.BRIGHT_RED:
        return "$_brightRed$message$_reset";
      case _TextColor.BRIGHT_GREEN:
        return "$_brightGreen$message$_reset";
      case _TextColor.BRIGHT_YELLOW:
        return "$_brightYellow$message$_reset";
      case _TextColor.BRIGHT_BLUE:
        return "$_brightBlue$message$_reset";
      case _TextColor.BRIGHT_MAGENTA:
        return "$_brightMagenta$message$_reset";
      case _TextColor.BRIGHT_CYAN:
        return "$_brightCyan$message$_reset";
      case _TextColor.BRIGHT_WHITE:
        return "$_brightWhite$message$_reset";
      case _TextColor.BOLD:
        return "$_bold$message$_reset";
      case _TextColor.ITALIC:
        return "$_italic$message$_reset";
      case _TextColor.UNDERLINE:
        return "$_underline$message$_reset";
      default:
        return message;
    }
  }

  static T? test<T>(
      {String? message,
      String title = "",
      StackTrace? stackTrace,
      String? userMessage,
      T? data,
      Resource? resource,
      Fail? fail}) {
    final Fail? error = fail ?? resource?.error;
    log(LogLevel.TEST,
        message: error?.exception.toString() ?? message,
        stackTrace: error?.stackTrace ?? stackTrace,
        title: resource != null ? "Resource: ${resource.status}" : title,
        data: data ?? resource?.data,
        userMessage: error?.userMessage ?? userMessage);
    return data;
  }

  static void info({String? message, String title = "", StackTrace? stackTrace, String? data}) {
    log(LogLevel.INFO, message: message, stackTrace: stackTrace, title: title, data: data);
  }

  static void warning({String? message, String title = "", StackTrace? stackTrace, String? data}) {
    log(LogLevel.WARNING, message: message, stackTrace: stackTrace, title: title, data: data);
  }

  static void error(
      {String? message,
      String title = "",
      StackTrace? stackTrace,
      String? userMessage,
      String? data,
      Fail? error}) {
    log(LogLevel.ERROR,
        message: error?.exception.toString() ?? message,
        stackTrace: error?.stackTrace ?? stackTrace,
        title: title,
        data: data,
        userMessage: error?.userMessage ?? userMessage);
  }

  static void sendLogToServer(String logMessage) {
    // Implement the logic to send logs to a remote server or save them to a file
    // Example: Use http package to send logs to a remote server
  }

  static String _getCurrentTime() {
    final now = DateTime.now();
    final hours = now.hour.toString().padLeft(2, '0');
    final minutes = now.minute.toString().padLeft(2, '0');
    final seconds = now.second.toString().padLeft(2, '0');
    final milliseconds = now.millisecond.toString().padLeft(3, '0');
    return "$hours:$minutes:$seconds.$milliseconds";
  }
}
