import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

import '../../../sddklibrary/util/fail.dart';

class CartState {
  final List<CartItem> items;
  late final double subTotal;
  late final double shippingFee;
  late final double discount;
  late final double total;
  final Address? selectedAddress;

  CartState({required this.items, required this.selectedAddress}) {
    CartUtil cartUtil = CartUtil(items);
    subTotal = cartUtil.subtotal;
    shippingFee = cartUtil.shippingFee;
    discount = cartUtil.discount;
    total = cartUtil.total;
  }

  CartState copyWith({List<CartItem>? items, Address? selectedAddress}) {
    return CartState(items: items ?? this.items, selectedAddress: selectedAddress ?? this.selectedAddress);
  }

  CartState calculateAndCopyWith({required List<CartItem> items, Address? selectedAddress}) {
    return CartState(items: items, selectedAddress: selectedAddress ?? this.selectedAddress);
  }
}

class InitialState extends CartState {
  InitialState() : super(items: [], selectedAddress: null);
}

class CartLoadingState extends CartState {
  CartLoadingState({

    required super.items, required super.selectedAddress,
  });
}

class CartFailState extends CartState {
  final Fail fail;

  CartFailState({
    required super.items,
    required this.fail, required super.selectedAddress,
  });
}

class CartSuccessState extends CartState {
  CartSuccessState({required super.items, required super.selectedAddress});
}
