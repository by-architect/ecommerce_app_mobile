import 'package:ecommerce_app_mobile/presentation/address/bloc/address_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

abstract  class MapService {

  Future<ResourceStatus<AddressState>> getAddressFromLongLtd(double latitude, double longitude);
}
