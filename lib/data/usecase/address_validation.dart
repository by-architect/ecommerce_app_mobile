import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/validation_result.dart';

import '../../common/ui/theme/AppText.dart';

class AddressValidation {
  static ValidationResult isValidAddress(AddressState address) {
    if (
    address.addressName == null ||
        address.addressName!.isEmpty ||
        address.phoneNo == null ||
        address.phoneNo!.isEmpty ||
        address.state == null ||
        address.state!.isEmpty ||
        address.city == null ||
        address.city!.isEmpty ||
        address.country == null ||
        address.country!.isEmpty ||
        address.area == null ||
        address.area!.isEmpty ||
        address.street == null ||
        address.street!.isEmpty ||
        address.streetNo == null ||
        address.streetNo!.isEmpty
    ) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }
    return ValidationResult(true);
  }
}
