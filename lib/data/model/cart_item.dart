import 'package:ecommerce_app_mobile/data/model/product.dart';

class CartItem {
  final Product product;
  final SubProduct subProduct;
  final int quantity;

  CartItem(this.product, this.subProduct, this.quantity);

  Map<String, dynamic> toMap(String uid) {
    return {
      "uid": uid,
      "sub_product_id": subProduct.id,
      "product_id": product.id,
      "quantity": quantity
    };
  }
}
