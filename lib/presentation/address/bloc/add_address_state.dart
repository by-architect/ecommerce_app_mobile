import 'dart:convert';

import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:latlong2/latlong.dart';

import '../../../sddklibrary/util/fail.dart';

class AddressState {
  late final String? id;
  late final String? uid;
  late final String? addressName;
  late final String? phoneNo;
  late final String? street;
  late final String? area;
  late final String? streetNo;
  late final String? floor;
  late final String? doorNo;
  late final String? state;
  late final String? city;
  late final String? country;
  late final String? postCode;
  late final double? longitude;
  late final double? latitude;
  late final String? openAddress;
  late final String? userNote;
  late final bool isSelected;

  AddressState(
      {required this.id,
      required this.addressName,
      required this.phoneNo,
      required this.uid,
      required this.street,
      required this.area,
      required this.streetNo,
      required this.floor,
      required this.doorNo,
      required this.state,
      required this.city,
      required this.country,
      required this.postCode,
      required this.longitude,
      required this.latitude,
      required this.openAddress,
      required this.userNote,
      this.isSelected = false});

  AddressState.fromMapService(String response) {
    final map = json.decode(response);
    final result = map['results'][0];
    final components = result['components'];

    Log.test(title: "address", data: components, message: components.runtimeType.toString());

    id = null;
    uid = null;
    addressName = null;
    street = components['road'];
    area = components['suburb'] ?? components['city_district'];
    postCode = components['postcode'];
    streetNo = components['house_number'];
    floor = null;
    doorNo = null;
    state = components['town'];
    city = components['city'] ?? components['state'];
    country = components['country'];
    longitude = result['geometry']['lng'];
    latitude = result['geometry']['lat'];
    openAddress = result['formatted'];
    userNote = null;
    phoneNo = null;
    isSelected = false;
  }

  AddressState.fromAddress(Address address) {
    id = address.id;
    uid = address.uid;
    addressName = address.addressName;
    phoneNo = address.phoneNo.toString();
    street = address.street;
    area = address.area;
    streetNo = address.streetNo;
    floor = address.floor.toString();
    doorNo = address.doorNo;
    state = address.state;
    city = address.city;
    country = address.country;
    postCode = address.postCode;
    longitude = address.longitude;
    latitude = address.latitude;
    openAddress = address.openAddress;
    userNote = address.userNote;
    isSelected = address.isSelected;
  }

  @override
  String toString() {
    return 'AddressState{id: $id, addressName: $addressName, phoneNo: $phoneNo, street: $street, area: $area, apartmentNo: $streetNo, floor: $floor, doorNo: $doorNo, city: $city, country: $country, longitude: $longitude, latitude: $latitude, openAddress: $openAddress, userNote: $userNote}';
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
      required super.uid,
      required super.addressName,
      required super.phoneNo,
      required super.street,
      required super.area,
      required super.streetNo,
      required super.floor,
      required super.doorNo,
      required super.city,
      required super.country,
      required super.longitude,
      required super.latitude,
      required super.openAddress,
      required super.userNote,
      required super.state,
      required super.postCode,
      required super.isSelected});

  AddAddressState copyWith(
      {bool? canPop,
      String? id,
      String? addressName,
      String? phoneNo,
      String? street,
      String? area,
      String? streetNo,
      String? floor,
      String? doorNo,
      String? state,
      String? city,
      String? country,
      String? postCode,
      double? longitude,
      double? latitude,
      String? openAddress,
      String? userNote,
      LatLng? currentLocation,
      LatLng? selectedLocation,
      String? uid,
      bool? isSelected}) {
    return AddAddressState(
        canPop: canPop ?? this.canPop,
        currentLocation: currentLocation ?? this.currentLocation,
        selectedLocation: selectedLocation ?? this.selectedLocation,
        id: id ?? this.id,
        uid: uid ?? this.uid,
        addressName: addressName ?? this.addressName,
        phoneNo: phoneNo ?? this.phoneNo,
        street: street ?? this.street,
        area: area ?? this.area,
        streetNo: streetNo ?? this.streetNo,
        floor: floor ?? this.floor,
        doorNo: doorNo ?? this.doorNo,
        state: state ?? this.state,
        city: city ?? this.city,
        country: country ?? this.country,
        postCode: postCode ?? this.postCode,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        openAddress: openAddress ?? this.openAddress,
        userNote: userNote ?? this.userNote,
        isSelected: isSelected ?? this.isSelected);
  }

  AddAddressState copyWithAddress(AddressState addressState) {
    return AddAddressState(
        canPop: canPop,
        currentLocation: currentLocation,
        selectedLocation: addressState.latitude != null && addressState.longitude != null
            ? LatLng(addressState.latitude!, addressState.longitude!)
            : null,
        uid: uid,
        id: addressState.id,
        addressName: addressState.addressName,
        phoneNo: addressState.phoneNo,
        street: addressState.street,
        area: addressState.area,
        streetNo: addressState.streetNo,
        floor: addressState.floor,
        doorNo: addressState.doorNo,
        state: addressState.state,
        city: addressState.city,
        country: addressState.country,
        postCode: addressState.postCode,
        longitude: addressState.longitude,
        latitude: addressState.latitude,
        openAddress: addressState.openAddress,
        userNote: addressState.userNote,
        isSelected: addressState.isSelected);
  }

  AddressState get getAddressState => AddressState(
      id: id,
      uid: uid,
      addressName: addressName,
      phoneNo: phoneNo,
      street: street,
      area: area,
      streetNo: streetNo,
      floor: floor,
      doorNo: doorNo,
      state: state,
      city: city,
      country: country,
      postCode: postCode,
      longitude: longitude,
      latitude: latitude,
      openAddress: openAddress,
      userNote: userNote,
      isSelected: isSelected);
}

class MapAddressFailState extends AddAddressState {
  final Fail fail;
  final AddAddressState addressState;

  MapAddressFailState({required this.fail, required this.addressState})
      : super(
            canPop: addressState.canPop,
            currentLocation: addressState.currentLocation,
            selectedLocation: addressState.selectedLocation,
            uid: addressState.uid,
            id: addressState.id,
            addressName: addressState.addressName,
            phoneNo: addressState.phoneNo,
            street: addressState.street,
            area: addressState.area,
            streetNo: addressState.streetNo,
            floor: addressState.floor,
            doorNo: addressState.doorNo,
            state: addressState.state,
            city: addressState.city,
            country: addressState.country,
            longitude: addressState.longitude,
            latitude: addressState.latitude,
            postCode: addressState.postCode,
            openAddress: addressState.openAddress,
            userNote: addressState.userNote,
            isSelected: addressState.isSelected);
}

class AddAddressLoadingState extends AddAddressState {
  final AddAddressState addressState;

  AddAddressLoadingState({required this.addressState})
      : super(
            canPop: addressState.canPop,
            currentLocation: addressState.currentLocation,
            selectedLocation: addressState.selectedLocation,
            uid: addressState.uid,
            id: addressState.id,
            addressName: addressState.addressName,
            phoneNo: addressState.phoneNo,
            street: addressState.street,
            area: addressState.area,
            streetNo: addressState.streetNo,
            floor: addressState.floor,
            doorNo: addressState.doorNo,
            state: addressState.state,
            city: addressState.city,
            country: addressState.country,
            longitude: addressState.longitude,
            latitude: addressState.latitude,
            openAddress: addressState.openAddress,
            userNote: addressState.userNote,
            postCode: addressState.postCode,
            isSelected: addressState.isSelected);
}

class AddAddressSuccessState extends AddAddressState {
  final AddAddressState addressState;

  AddAddressSuccessState({required this.addressState})
      : super(
            canPop: addressState.canPop,
            currentLocation: addressState.currentLocation,
            selectedLocation: addressState.selectedLocation,
            uid: addressState.uid,
            id: addressState.id,
            addressName: addressState.addressName,
            phoneNo: addressState.phoneNo,
            street: addressState.street,
            area: addressState.area,
            streetNo: addressState.streetNo,
            floor: addressState.floor,
            doorNo: addressState.doorNo,
            state: addressState.state,
            city: addressState.city,
            country: addressState.country,
            longitude: addressState.longitude,
            latitude: addressState.latitude,
            openAddress: addressState.openAddress,
            userNote: addressState.userNote,
            postCode: addressState.postCode,
            isSelected: addressState.isSelected);
}

class AddAddressFailState extends AddAddressState {
  final Fail fail;
  final AddAddressState addressState;

  AddAddressFailState({required this.fail, required this.addressState})
      : super(
            canPop: addressState.canPop,
            currentLocation: addressState.currentLocation,
            selectedLocation: addressState.selectedLocation,
            uid: addressState.uid,
            id: addressState.id,
            addressName: addressState.addressName,
            phoneNo: addressState.phoneNo,
            street: addressState.street,
            area: addressState.area,
            streetNo: addressState.streetNo,
            floor: addressState.floor,
            doorNo: addressState.doorNo,
            state: addressState.state,
            city: addressState.city,
            country: addressState.country,
            longitude: addressState.longitude,
            latitude: addressState.latitude,
            openAddress: addressState.openAddress,
            userNote: addressState.userNote,
            postCode: addressState.postCode,
            isSelected: addressState.isSelected);
}

class InitialAddressState extends AddAddressState {
  InitialAddressState()
      : super(
          selectedLocation: null,
          currentLocation: null,
          canPop: true,
          uid: null,
          id: null,
          openAddress: null,
          doorNo: null,
          city: null,
          streetNo: null,
          area: null,
          addressName: null,
          state: null,
          country: null,
          floor: null,
          postCode: null,
          latitude: null,
          longitude: null,
          phoneNo: null,
          street: null,
          userNote: null,
          isSelected: false,
        );
}
