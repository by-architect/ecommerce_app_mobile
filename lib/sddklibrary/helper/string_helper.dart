extension StringExtentions on String{
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
}

class StringHelper{

static  String capitalizeFirstWord(String sentence) {
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
