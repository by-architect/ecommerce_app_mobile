import 'dart:convert';

import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../data/model/address.dart';

class AddressesState {
  final List<Address> addresses;

  AddressesState({required this.addresses});

  AddressesState copyWith({List<Address>? addresses}) {
    return AddressesState(
      addresses: addresses ?? this.addresses,
    );
  }
}

class AddressesLoadingState extends AddressesState {
  AddressesLoadingState({required super.addresses});
}

class InitialAddressesState extends AddressesState {
  InitialAddressesState() : super(addresses: []);
}

class AddressesSuccessState extends AddressesState {
  AddressesSuccessState({required super.addresses});
}

class AddressesFailState extends AddressesState {
  final Fail fail;

  AddressesFailState({required this.fail, required super.addresses});
}
