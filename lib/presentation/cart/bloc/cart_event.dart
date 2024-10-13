import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

class CartEvent{}

class ChangeCartItem extends CartEvent{
  final CartItem cartItem;

  ChangeCartItem({required this.cartItem,});
}

class GetCart extends CartEvent{}
