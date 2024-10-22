import 'dart:convert';

import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../data/model/address.dart';

class AddressesState {
  final List<Address> addresses;
  final bool editMode;

  AddressesState({required this.editMode,required this.addresses});

  AddressesState copyWith({List<Address>? addresses, bool? editMode}) {
    return AddressesState(
      addresses: addresses ?? this.addresses,
      editMode: editMode ?? this.editMode,
    );
  }
}

class AddressesLoadingState extends AddressesState {
  AddressesLoadingState({required super.addresses, required super.editMode});
}

class InitialAddressesState extends AddressesState {
  InitialAddressesState() : super(addresses: [], editMode: false);
}

class AddressesSuccessState extends AddressesState {
  AddressesSuccessState({required super.addresses, required super.editMode});
}

class AddressesFailState extends AddressesState {
  final Fail fail;

  AddressesFailState({required this.fail, required super.addresses, required super.editMode});
}
