import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';

import '../../data/model/money.dart';

class PurchaseSummary {
  final List<ProductWithQuantity> items;
  late final Money subtotal;
  late final Money shippingFee;
  late final Money discount;
  late final Money total;

  PurchaseSummary(this.items, Money defaultShippingFee) {
    subtotal = _calculateSubtotal();
    shippingFee = _calculateShippingFee(defaultShippingFee);
    discount = _calculateDiscount();
    total = _calculateTotal();
  }

  PurchaseSummary.fromCartItems(List<CartItem> cartItems, Money defaultShippingFee)
      : items = cartItems.map((e) => e.productWithQuantity).toList() {
    subtotal = _calculateSubtotal();
    shippingFee = _calculateShippingFee(defaultShippingFee);
    discount = _calculateDiscount();
    total = _calculateTotal();
  }

  Money _calculateSubtotal() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.price.amount;
    }
    return Money( result);
  }

  Money _calculateShippingFee(Money defaultShippingFee) {
    return defaultShippingFee;
  }

  Money _calculateDiscount() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.discount.amount;
    }
    return Money( result);
  }

  Money _calculateTotal() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.priceAfterDiscounting.amount;
    }
    result += shippingFee.amount;
    return Money( result);
  }
}
