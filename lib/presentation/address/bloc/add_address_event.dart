import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class AddAddressEvent {}
class PopBackEvent extends AddAddressEvent {
  final bool canPop;

  PopBackEvent(this.canPop);
}
class SetCurrentLocation extends AddAddressEvent {
  final LatLng latLng;
  SetCurrentLocation(this.latLng);
}
class SetSelectedLocation extends AddAddressEvent {
  final LatLng latLng;
  SetSelectedLocation(this.latLng);
}

class SetInitialLocation extends AddAddressEvent {
  final LatLng latLng;
  SetInitialLocation(this.latLng);
}

class SetTitle extends AddAddressEvent {
  final String title;
  SetTitle(this.title);
}
class SetPhoneNo extends AddAddressEvent {
  final String phoneNo;
  SetPhoneNo(this.phoneNo);
}
class SetStreet extends AddAddressEvent {
  final String street;
  SetStreet(this.street);
}
class SetArea extends AddAddressEvent {
  final String area;
  SetArea(this.area);
}
class SetStreetNo extends AddAddressEvent {
  final String streetNo;
  SetStreetNo(this.streetNo);
}

class SetFloor extends AddAddressEvent {
  final String floor;
  SetFloor(this.floor);
}

class SetDoorNo extends AddAddressEvent {
  final String doorNo;
  SetDoorNo(this.doorNo);
}

class SetState extends AddAddressEvent {
  final String state;
  SetState(this.state);
}

class SetCity extends AddAddressEvent {
  final String city;
  SetCity(this.city);
}

class SetCountry extends AddAddressEvent {
  final String country;
  SetCountry(this.country);
}
class SetUserNote extends AddAddressEvent {
  final String userNote;
  SetUserNote(this.userNote);
}

class AddAddressToServer extends AddAddressEvent {
  AddAddressToServer();
}