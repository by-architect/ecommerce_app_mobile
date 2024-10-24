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
  final String creditCardNameSurname;
  final String creditCardNumber;
  final String creditCardExpiryDate;
  final String creditCardCvv;

  CartState(
      {required this.creditCardNameSurname,
      required this.creditCardNumber,
      required this.creditCardExpiryDate,
      required this.creditCardCvv,
      required this.items,
      required this.selectedAddress}) {
    CartUtil cartUtil = CartUtil(items);
    subTotal = cartUtil.subtotal;
    shippingFee = cartUtil.shippingFee;
    discount = cartUtil.discount;
    total = cartUtil.total;
  }

  CartState copyWith(
      {String? creditCardNameSurname,
      String? creditCardNumber,
      String? creditCardExpiryDate,
      String? creditCardCvv,
      List<CartItem>? items,
      Address? selectedAddress}) {
    return CartState(
        items: items ?? this.items,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        creditCardNameSurname: creditCardNameSurname ?? this.creditCardNameSurname,
        creditCardNumber: creditCardNumber ?? this.creditCardNumber,
        creditCardExpiryDate: creditCardExpiryDate ?? this.creditCardExpiryDate,
        creditCardCvv: creditCardCvv ?? this.creditCardCvv);
  }

  CartState calculateAndCopyWith({required List<CartItem> items, Address? selectedAddress}) {
    return CartState(
        items: items,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        creditCardNameSurname: creditCardNameSurname,
        creditCardNumber: creditCardNumber,
        creditCardExpiryDate: creditCardExpiryDate,
        creditCardCvv: creditCardCvv);
  }

  @override
  String toString() {
    return 'CartState{items: $items, subTotal: $subTotal, shippingFee: $shippingFee, discount: $discount, total: $total, selectedAddress: $selectedAddress, creditCardNameSurname: $creditCardNameSurname, creditCardNumber: $creditCardNumber, creditCardExpiryDate: $creditCardExpiryDate, creditCardCvv: $creditCardCvv}';
  }
}

class InitialState extends CartState {
  InitialState()
      : super(
            items: [],
            selectedAddress: null,
            creditCardNameSurname: "",
            creditCardNumber: "",
            creditCardExpiryDate: "",
            creditCardCvv: "");
}

class CartLoadingState extends CartState {
  final CartState cartState;

  CartLoadingState(this.cartState)
      : super(
            creditCardNameSurname: cartState.creditCardNameSurname,
            creditCardNumber: cartState.creditCardNumber,
            creditCardExpiryDate: cartState.creditCardExpiryDate,
            creditCardCvv: cartState.creditCardCvv,
            items: cartState.items,
            selectedAddress: cartState.selectedAddress);
}

class CartFailState extends CartState {
  final Fail fail;
  final CartState cartState;

  CartFailState({required this.fail, required this.cartState})
      : super(
            creditCardNameSurname: cartState.creditCardNameSurname,
            creditCardNumber: cartState.creditCardNumber,
            creditCardExpiryDate: cartState.creditCardExpiryDate,
            creditCardCvv: cartState.creditCardCvv,
            items: cartState.items,
            selectedAddress: cartState.selectedAddress);
}

class CartSuccessState extends CartState {
  final CartState cartState;

  CartSuccessState(this.cartState)
      : super(
            creditCardNameSurname: cartState.creditCardNameSurname,
            creditCardNumber: cartState.creditCardNumber,
            creditCardExpiryDate: cartState.creditCardExpiryDate,
            creditCardCvv: cartState.creditCardCvv,
            items: cartState.items,
            selectedAddress: cartState.selectedAddress);
}
