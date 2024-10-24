import 'package:ecommerce_app_mobile/data/model/address.dart';
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

class NameSurnameEvent extends CartEvent{
  final String nameSurname;
  NameSurnameEvent({required this.nameSurname});
}

class CardNumberEvent extends CartEvent{
  final String cardNumber;
  CardNumberEvent({required this.cardNumber});
}

class ExpirationDateEvent extends CartEvent{
  final String expirationDate;
  ExpirationDateEvent({required this.expirationDate});
}

class CvvEvent extends CartEvent{
  final String cvv;
  CvvEvent({required this.cvv});
}
class SelectAddress extends CartEvent{
  final Address address;
  SelectAddress({required this.address});
}

class GetSelectedAddress extends CartEvent{
  final User user;
  GetSelectedAddress(this.user);
}
