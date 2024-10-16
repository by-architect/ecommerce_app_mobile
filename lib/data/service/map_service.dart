

import '../../presentation/address/bloc/add_address_state.dart';
import '../../sddklibrary/util/resource.dart';

abstract  class MapService {

  Future<ResourceStatus<AddressState>> getAddressFromLongLtd(double latitude, double longitude);
}
