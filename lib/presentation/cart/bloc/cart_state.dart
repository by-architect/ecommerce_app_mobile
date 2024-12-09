import 'package:ecommerce_app_mobile/common/util/cart_util.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';

import '../../../data/model/money.dart';
import '../../../sddklibrary/util/fail.dart';

class CartState {
  final List<CartItem> items;
  late final PurchaseSummary purchaseSummary;
  final Address? selectedAddress;
  final String creditCardNameSurname;
  final String creditCardNumber;
  final String creditCardExpiryDate;
  final String creditCardCvv;

  final Money defaultShippingFee;

  CartState._(
      {required this.creditCardNameSurname,
      required this.creditCardNumber,
      required this.creditCardExpiryDate,
      required this.creditCardCvv,
      required this.items,
        required this.defaultShippingFee,
      required this.selectedAddress,}) {
    purchaseSummary = PurchaseSummary.fromCartItems(items,defaultShippingFee);
  }

  CartState copyWith(
      {String? creditCardNameSurname,
      String? creditCardNumber,
      String? creditCardExpiryDate,
      String? creditCardCvv,
      Money? defaultShippingFee,
      List<CartItem>? items,
      Address? selectedAddress}) {
    return CartState._(
        items: items ?? this.items,
        defaultShippingFee: defaultShippingFee ?? this.defaultShippingFee,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        creditCardNameSurname:
            creditCardNameSurname ?? this.creditCardNameSurname,
        creditCardNumber: creditCardNumber ?? this.creditCardNumber,
        creditCardExpiryDate: creditCardExpiryDate ?? this.creditCardExpiryDate,
        creditCardCvv: creditCardCvv ?? this.creditCardCvv);
  }

  CartState calculateAndCopyWith(
      {required List<CartItem> items,required Money defaultShippingFee, Address? selectedAddress}) {
    return CartState._(
        items: items,
        defaultShippingFee: defaultShippingFee,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        creditCardNameSurname: creditCardNameSurname,
        creditCardNumber: creditCardNumber,
        creditCardExpiryDate: creditCardExpiryDate,
        creditCardCvv: creditCardCvv);
  }

  @override
  String toString() {
    return 'CartState{items: $items, purchaseSummary: $purchaseSummary, selectedAddress: $selectedAddress, creditCardNameSurname: $creditCardNameSurname, creditCardNumber: $creditCardNumber, creditCardExpiryDate: $creditCardExpiryDate, creditCardCvv: $creditCardCvv}';
  }
}

class InitialState extends CartState {
  InitialState()
      : super._(
            items: [],
            selectedAddress: null,
            defaultShippingFee: Money( 0),
            creditCardNameSurname: "",
            creditCardNumber: "",
            creditCardExpiryDate: "",
            creditCardCvv: "");
}

class CartLoadingState extends CartState {
  final CartState cartState;

  CartLoadingState(this.cartState)
      : super._(
            creditCardNameSurname: cartState.creditCardNameSurname,
            creditCardNumber: cartState.creditCardNumber,
            creditCardExpiryDate: cartState.creditCardExpiryDate,
            creditCardCvv: cartState.creditCardCvv,
            items: cartState.items,
            defaultShippingFee: cartState.defaultShippingFee,
            selectedAddress: cartState.selectedAddress);
}

class CartFailState extends CartState {
  final Fail fail;
  final CartState cartState;

  CartFailState({required this.fail, required this.cartState})
      : super._(
            creditCardNameSurname: cartState.creditCardNameSurname,
            creditCardNumber: cartState.creditCardNumber,
            creditCardExpiryDate: cartState.creditCardExpiryDate,
            creditCardCvv: cartState.creditCardCvv,
            defaultShippingFee: cartState.defaultShippingFee,
            items: cartState.items,
            selectedAddress: cartState.selectedAddress);
}

class CartSuccessState extends CartState {
  final CartState cartState;

  CartSuccessState(this.cartState)
      : super._(
            creditCardNameSurname: cartState.creditCardNameSurname,
            creditCardNumber: cartState.creditCardNumber,
            creditCardExpiryDate: cartState.creditCardExpiryDate,
            creditCardCvv: cartState.creditCardCvv,
            items: cartState.items,
            defaultShippingFee: cartState.defaultShippingFee,
            selectedAddress: cartState.selectedAddress);
}
