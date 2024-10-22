
class Address {
  final String id;
  final String uid;
  final String addressName;
  final int phoneNo;
  final String street; //sokak
  final String area; //mahalle
  final String streetNo;
  final int floor;
  final String doorNo;
  final String state; // ilçe
  final String city; //il
  final String country; // ülke
  final String postCode;
  final double latitude;
  final double longitude;
  final String openAddress;
  final String userNote;
  final bool isSelected;

  Address(
      {required this.addressName,
      required this.id,
      required this.uid,
      required this.phoneNo,
      required this.street,
      required this.area,
      required this.streetNo,
      required this.floor,
      required this.doorNo,
      required this.state,
      required this.city,
      required this.country,
      required this.postCode,
      required this.latitude,
      required this.longitude,
      required this.openAddress,
      required this.isSelected,
      required this.userNote});

  Address copyWith({
    String? addressName,
    String? id,
    int? phoneNo,
    String? street,
    String? area,
    String? streetNo,
    int? floor,
    String? doorNo,
    String? state,
    String? city,
    String? country,
    String? postCode,
    double? latitude,
    double? longitude,
    String? openAddress,
    bool? isSelected,
    String? userNote,
    String? uid
  }) {
    return Address(
      addressName: addressName ?? this.addressName,
      id: id ?? this.id,
      uid: uid ?? this.uid,
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
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openAddress: openAddress ?? this.openAddress,
      isSelected: isSelected ?? this.isSelected,
      userNote: userNote ?? this.userNote,
    );
  }
}
