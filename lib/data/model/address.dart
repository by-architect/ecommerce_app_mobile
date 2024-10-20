
class Address {
  final String id;
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

  Address(
      {required this.addressName,
      required this.id,
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
      required this.userNote});
}
