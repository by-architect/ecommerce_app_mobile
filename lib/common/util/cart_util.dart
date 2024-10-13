import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

class CartUtil {
  final List<CartItem> items;

  CartUtil(this.items);

  double calculateSubtotal() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.price;
    }
    return result;
  }

  double calculateShippingFee() {
    return FakeAppDefaults.shippingFee;
  }

  double calculateDiscount() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.discount;
    }
    return result;
  }

  double calculateTotal() {
    double result = 0;
    for (var item in items) {
      result += item.quantity * item.subProduct.priceAfterDiscounting;
    }
    return result;
  }
}
