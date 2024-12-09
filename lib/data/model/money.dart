import 'package:ecommerce_app_mobile/common/constant/currency.dart';

class Money {
  final double amount;

  String get _clearZero => amount.truncate() == amount
      ? amount.toStringAsFixed(0)
      : amount.toStringAsFixed(2);

  Money(this.amount);

  bool isEqualTo(Money other) {
    return amount == other.amount;
  }

  Money subtract(Money other) {
    return Money(amount - other.amount);
  }

  bool isGreaterThan(Money other) {
    return amount > other.amount;
  }

  bool get isZero {
    return amount == 0.0;
  }

  String  displayAmount(Currency currency) {
    return currency.toLeft
        ? "${currency.sign} $_clearZero"
        : "$_clearZero ${currency.sign}";
  }
}
