import 'package:ecommerce_app_mobile/data/model/address.dart';

import '../../../data/model/user.dart';

class AddressesEvent{}

class GetAddressesEvent extends AddressesEvent{
  final User user;

  GetAddressesEvent(this.user);
}
class SelectAddressEvent extends AddressesEvent{
  final Address address;
  final User user;
    SelectAddressEvent(this.address, this.user);
}