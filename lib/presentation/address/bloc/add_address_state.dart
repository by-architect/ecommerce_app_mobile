import 'dart:convert';

import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:latlong2/latlong.dart';

import '../../../sddklibrary/util/fail.dart';

class AddressState {
  late final String? id;
  late final String? addressName;
  late final int? phoneNo;
  late final String? street;
  late final String? area;
  late final String? apartmentNo;
  late final int? floor;
  late final String? doorNo;
  late final String? city;
  late final String? country;
  late final double? longitude;
  late final double? latitude;
  late final String? openAddress;
  late final String? userNote;

  AddressState(
      {required this.id,
      required this.addressName,
      required this.phoneNo,
      required this.street,
      required this.area,
      required this.apartmentNo,
      required this.floor,
      required this.doorNo,
      required this.city,
      required this.country,
      required this.longitude,
      required this.latitude,
      required this.openAddress,
      required this.userNote});


  AddressState.fromMapService(String response) {
    final map = json.decode(response);
    final result = map['results'][0];
    final components = result['components'];

    id = null;
    addressName = null;
    street = components['road'];
    area = components['suburb'] ?? components['city_district'];
    apartmentNo = null;
    floor = null;
    doorNo = null;
    city = components['state'];
    country = components['country'];
    longitude = result['geometry']['lng'];
    latitude = result['geometry']['lat'];
    openAddress = result['formatted'];
    userNote = null;
    phoneNo = null;
  }

  AddressState.fromAddress(Address address) {
    id = address.id;
    addressName = address.addressName;
    phoneNo = address.phoneNo;
    street = address.street;
    area = address.area;
    apartmentNo = address.apartmentNo;
    floor = address.floor;
    doorNo = address.doorNo;
    city = address.city;
    country = address.country;
    longitude = address.longitude;
    latitude = address.latitude;
    openAddress = address.openAddress;
    userNote = address.userNote;
  }

  @override
  String toString() {
    return 'AddressState{id: $id, addressName: $addressName, phoneNo: $phoneNo, street: $street, area: $area, apartmentNo: $apartmentNo, floor: $floor, doorNo: $doorNo, city: $city, country: $country, longitude: $longitude, latitude: $latitude, openAddress: $openAddress, userNote: $userNote}';
  }
}

class AddAddressState extends AddressState {
  final bool canPop;
  final LatLng? currentLocation;
  final LatLng? selectedLocation;

  AddAddressState(
      {required super.id,
     required this.currentLocation,
     required this.selectedLocation,
      required this.canPop,
      required super.addressName,
      required super.phoneNo,
      required super.street,
      required super.area,
      required super.apartmentNo,
      required super.floor,
      required super.doorNo,
      required super.city,
      required super.country,
      required super.longitude,
      required super.latitude,
      required super.openAddress,
      required super.userNote});

  AddAddressState copyWith(
      {bool? canPop,
      String? id,
      String? addressName,
      int? phoneNo,
      String? street,
      String? area,
      String? apartmentNo,
      int? floor,
      String? doorNo,
      String? city,
      String? country,
      double? longitude,
      double? latitude,
      String? openAddress,
      String? userNote,
      LatLng? currentLocation,
      LatLng? selectedLocation}) {
    return AddAddressState(
      canPop: canPop ?? this.canPop,
      currentLocation: currentLocation ?? this.currentLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      id: id,
      addressName: addressName,
      phoneNo: phoneNo,
      street: street,
      area: area,
      apartmentNo: apartmentNo,
      floor: floor,
      doorNo: doorNo,
      city: city,
      country: country,
      longitude: longitude,
      latitude: latitude,
      openAddress: openAddress,
      userNote: userNote,
    );
  }

  AddAddressState copyWithAddress(AddressState addressState) {
    return AddAddressState(
      canPop: canPop,
      currentLocation: currentLocation,
      selectedLocation:
          addressState.latitude != null && addressState.longitude != null ? LatLng(addressState.latitude!, addressState.longitude!) : null,
      id: addressState.id,
      addressName: addressState.addressName,
      phoneNo: addressState.phoneNo,
      street: addressState.street,
      area: addressState.area,
      apartmentNo: addressState.apartmentNo,
      floor: addressState.floor,
      doorNo: addressState.doorNo,
      city: addressState.city,
      country: addressState.country,
      longitude: addressState.longitude,
      latitude: addressState.latitude,
      openAddress: addressState.openAddress,
      userNote: addressState.userNote,
    );
  }
}

class AddAddressFailState extends AddAddressState {
  final Fail fail;

  AddAddressFailState(
      {
        required this.fail,
      required super.id,
      required super.addressName,
      required super.phoneNo,
      required super.street,
      required super.area,
      required super.apartmentNo,
      required super.floor,
      required super.doorNo,
      required super.city,
      required super.country,
      required super.longitude,
      required super.latitude,
      required super.openAddress,
      required super.userNote, required super.canPop, required super.currentLocation, required super.selectedLocation});
}

class InitialAddressState extends AddAddressState {
  InitialAddressState()
      : super(
    selectedLocation: null,
    currentLocation: null,
            canPop: true,
            id: null,
            openAddress: null,
            doorNo: null,
            city: null,
            apartmentNo: null,
            area: null,
            addressName: null,
            country: null,
            floor: null,
            latitude: null,
            longitude: null,
            phoneNo: null,
            street: null,
            userNote: null);
}
