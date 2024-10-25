extension StringExtentions on String {
  BigInt get toLongPhone {
    String numbersOnly = replaceAll(RegExp(r'\D'), '');
    BigInt phoneNumber = BigInt.parse(numbersOnly);
    return phoneNumber;
  }

  bool get isDigit => RegExp(r'^\d+$').hasMatch(this);

  int get toInt => int.parse(this);

  String get capitalizeFirstWord {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String get clearSpaces => replaceAll(RegExp(r'\s+'), ' ').trim();

  bool get isHexColor  {
    if (isEmpty) {
      return false;
    }

    try {
      int colorValue = int.parse(this);
      if (colorValue < 0 || colorValue > 4294967295) {
        return false;
      }

      int alpha = (colorValue >> 24) & 0xFF;
      if (alpha < 0 || alpha > 255) {
        return false;
      }
      int red = (colorValue >> 16) & 0xFF;
      int green = (colorValue >> 8) & 0xFF;
      int blue = colorValue & 0xFF;
      return red >= 0 && red <= 255 && green >= 0 && green <= 255 && blue >= 0 && blue <= 255;
    } catch (e) {
      return false;
    }
  }
}

class StringHelper {
  static String capitalizeFirstWord(String sentence) {
    if (sentence.isEmpty) return sentence;
    return sentence[0].toUpperCase() + sentence.substring(1);
  }

  static String capitalizeEveryWord(String sentence) {
    return sentence.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
