import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

class CartUtil {
  final List<CartItem> items;
  late final double subtotal;
  late final double shippingFee;
  late final double discount;
  late final double total;

  CartUtil(this.items) {
    subtotal = _calculateSubtotal();
    shippingFee = _calculateShippingFee();
    discount = _calculateDiscount();
    total = _calculateTotal();
  }

  double _calculateSubtotal() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.price;
    }
    return result;
  }

  double _calculateShippingFee() {
    return FakeAppDefaults.shippingFee;
  }

  double _calculateDiscount() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.discount;
    }
    return result;
  }

  double _calculateTotal() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.priceAfterDiscounting;
    }
    result += shippingFee;
    return result;
  }
}
