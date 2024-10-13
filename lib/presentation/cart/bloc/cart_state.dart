import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

import '../../../sddklibrary/util/fail.dart';

class CartState {
  final List<CartItem> items;
  final double subTotal;
  final double shippingFee;
  final double discount;
  final double total;

  CartState(
      {required this.items,
      required this.subTotal,
      required this.shippingFee,
      required this.discount,
      required this.total});

  CartState _copyWith({
    List<CartItem>? items,
    double? subTotal,
    double? shippingFee,
    double? discount,
    double? total,
  }) {
    return CartState(
        items: items ?? this.items,
        subTotal: subTotal ?? this.subTotal,
        shippingFee: shippingFee ?? this.shippingFee,
        discount: discount ?? this.discount,
        total: total ?? this.total);
  }

  CartState calculateAndCopyWith({
    List<CartItem>? items,
    double? subTotal,
    double? shippingFee,
    double? discount,
    double? total,
  }) {
    if (items != null) {
      final cartUtil = new CartUtil(items);
      return CartState(
          items: items,
          subTotal: cartUtil.subtotal,
          shippingFee: cartUtil.shippingFee,
          discount: cartUtil.discount,
          total: cartUtil.total);
    } else {
      return CartState(
          items: items ?? this.items,
          subTotal: subTotal ?? this.subTotal,
          shippingFee: shippingFee ?? this.shippingFee,
          discount: discount ?? this.discount,
          total: total ?? this.total);
    }
  }
}

class InitialState extends CartState {
  InitialState() : super(discount: 0, items: [], shippingFee: 0, subTotal: 0, total: 0);
}

class CartLoadingState extends CartState {
  CartLoadingState(
      {required super.items,
      required super.subTotal,
      required super.shippingFee,
      required super.discount,
      required super.total});
}

class CartFailState extends CartState {
  final Fail fail;

  CartFailState(
      {required super.items,
      required super.subTotal,
      required super.shippingFee,
      required this.fail,
      required super.discount,
      required super.total});
}

class CartSuccessState extends CartState {
  CartSuccessState(
      {required super.items,
      required super.subTotal,
      required super.shippingFee,
      required super.discount,
      required super.total}) {
    //todo: calculate and copy with method
  }
}
