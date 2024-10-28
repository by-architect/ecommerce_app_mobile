import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';

class CartItem {
  final String id;
  final Product product;
  final SubProduct subProduct;
  final int quantity;

  CartItem(
      {required this.product,
      required this.subProduct,
      required this.quantity,
      required this.id});

  CartItem copyWith({
    Product? product,
    SubProduct? subProduct,
    int? quantity,
  }) {
    return CartItem(
        product: product ?? this.product,
        subProduct: subProduct ?? this.subProduct,
        quantity: quantity ?? this.quantity,
        id: id);
  }

  CartItem increaseQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  CartItem decreaseQuantity() {
    return copyWith(quantity: quantity -1);
  }

}
