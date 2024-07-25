
import 'dart:io';

extension StringHelper on String{
  BigInt get toLongPhone {
    String numbersOnly = replaceAll(RegExp(r'\D'), '');
    BigInt phoneNumber = BigInt.parse(numbersOnly);
    return phoneNumber;
  }
  bool get isDigit => RegExp(r'^-?[0-9]+$').hasMatch(this);
  int get toInt => int.parse(this);
}

class Helper  {
  static String get systemLanguageCode => Platform.localeName.split('_')[0];
}