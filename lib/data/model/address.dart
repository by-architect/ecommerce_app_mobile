import 'dart:ffi';

class Address {
  final String id;
  final String addressName;
  final int phoneNo;
  final String street;
  final String area;
  final String apartmentNo;
  final int floor;
  final String doorNo;
  final String state;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  final String openAddress;
  final String userNote;

  Address(
      {required this.addressName,
      required this.id,
      required this.phoneNo,
      required this.street,
      required this.area,
      required this.apartmentNo,
      required this.floor,
      required this.doorNo,
      required this.state,
      required this.city,
      required this.country,
      required this.latitude,
      required this.longitude,
      required this.openAddress,
      required this.userNote});
}
