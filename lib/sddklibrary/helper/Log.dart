import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum LogLevel { DEBUG, INFO, WARNING, ERROR }

class Log {
  static const String _reset = "\x1B[0m";
  static const String _red = "\x1B[31m";
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _blue = "\x1B[34m";

  static void log(String title, String message, {LogLevel level = LogLevel.DEBUG}) {
    final timestamp = _getCurrentTime();
    final coloredMessage = "$timestamp ${_getColoredMessage("$title $message", level)}";

    if (kReleaseMode) {
      // In production, send logs to a remote server or a file
      // sendLogToServer(coloredMessage);
    } else {
      // In debug mode, print logs to the console
      debugPrint(coloredMessage);
    }
  }

  static String _getColoredMessage(String message, LogLevel level) {
    switch (level) {
      case LogLevel.DEBUG:
        return "$_blue$message$_reset";
      case LogLevel.INFO:
        return "$_green$message$_reset";
      case LogLevel.WARNING:
        return "$_yellow$message$_reset";
      case LogLevel.ERROR:
        return "$_red$message$_reset";
      default:
        return message;
    }
  }

  static void test(String title, {String message = ""}) {
    final log = "$_yellow${_getCurrentTime()}$_reset $_blue$title$_reset $_green$message$_reset";
    debugPrint(log);
  }

  static void debug(String title, String message) {
    log(title, message, level: LogLevel.DEBUG);
  }

  static void info(String, title, String message) {
    log(title, message, level: LogLevel.INFO);
  }

  static void warning(String title, String message) {
    log(title, message, level: LogLevel.WARNING);
  }

  static void error(String title, String message) {
    log(title, message, level: LogLevel.ERROR);
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
