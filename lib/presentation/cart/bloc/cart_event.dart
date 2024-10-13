import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

import '../../../data/model/user.dart';

class CartEvent{}

class ChangeCartItem extends CartEvent{
  final CartItem cartItem;
  final User user;

  ChangeCartItem({required this.cartItem,required this.user});
}

class GetCart extends CartEvent{
  final User user;

  GetCart(this.user);
}
