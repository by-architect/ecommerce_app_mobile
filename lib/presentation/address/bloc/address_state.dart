import 'dart:convert';

class AddressState {
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
      {required this.addressName,
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

  AddressState.fromMap(String response) {
    final map = json.decode(response);
    final result = map['results'][0];
    final components = result['components'];

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

  AddressState copyWith({
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
  }) {
    return AddressState(
      addressName: addressName ?? this.addressName,
      phoneNo: phoneNo ?? this.phoneNo,
      street: street ?? this.street,
      area: area ?? this.area,
      apartmentNo: apartmentNo ?? this.apartmentNo,
      floor: floor ?? this.floor,
      doorNo: doorNo ?? this.doorNo,
      city: city ?? this.city,
      country: country ?? this.country,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      openAddress: openAddress ?? this.openAddress,
      userNote: userNote ?? this.userNote,
    );
  }

  @override
  String toString() {
    return 'AddressState{addressName: $addressName, phoneNo: $phoneNo, street: $street, area: $area, apartmentNo: $apartmentNo, floor: $floor, doorNo: $doorNo,  city: $city, country: $country, longitude: $longitude, latitude: $latitude, openAddress: $openAddress, userNote: $userNote}';
  }
}
