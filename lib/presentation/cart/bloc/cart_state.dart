import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

import '../../../sddklibrary/util/fail.dart';

class CartState {
  final List<CartItem> items;
  late final double subTotal;
  late final double shippingFee;
  late final double discount;
  late final double total;

  CartState({
    required this.items,
  }) {
    CartUtil cartUtil = CartUtil(items);
    subTotal = cartUtil.subtotal;
    shippingFee = cartUtil.shippingFee;
    discount = cartUtil.discount;
    total = cartUtil.total;
  }

  CartState calculateAndCopyWith({
    required List<CartItem> items,
  }) {
    return CartState(items: items);
  }
}

class InitialState extends CartState {
  InitialState() : super(items: []);
}

class CartLoadingState extends CartState {
  CartLoadingState(
      {required super.items,
      });
}

class CartFailState extends CartState {
  final Fail fail;

  CartFailState(
      {required super.items,
      required this.fail,
      });
}

class CartSuccessState extends CartState {
  CartSuccessState({required super.items});
}
