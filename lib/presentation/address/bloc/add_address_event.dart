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