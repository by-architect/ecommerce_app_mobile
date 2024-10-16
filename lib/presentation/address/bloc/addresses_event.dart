import '../../../data/model/user.dart';

class AddressesEvent{}

class GetAddressesEvent extends AddressesEvent{
  final User user;

  GetAddressesEvent(this.user);
}