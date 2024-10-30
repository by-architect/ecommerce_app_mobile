import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';

class CartItem {
  final String id;
  final ProductWithQuantity productWithQuantity;

  CartItem({required this.productWithQuantity, required this.id});

  CartItem copyWith({
    ProductWithQuantity? productWithQuantity,
    int? quantity,
  }) {
    return CartItem(productWithQuantity: productWithQuantity ?? this.productWithQuantity, id: id);
  }

  CartItem increaseQuantity() {
    return copyWith(productWithQuantity: productWithQuantity.increaseQuantity());
  }

  CartItem decreaseQuantity() {
    return copyWith(productWithQuantity: productWithQuantity.decreaseQuantity());
  }
}
