
extension StringHelper on String{
  BigInt get toLongPhone {
    String numbersOnly = replaceAll(RegExp(r'\D'), '');
    BigInt phoneNumber = BigInt.parse(numbersOnly);
    return phoneNumber;
  }
}

class Helper  {
}