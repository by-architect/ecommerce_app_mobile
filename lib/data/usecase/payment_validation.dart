import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/validation_result.dart';

import '../../common/ui/theme/AppText.dart';

class PaymentValidation {
 static ValidationResult validate(CartState state) {
    if (state.creditCardNameSurname.isEmpty ||
        state.creditCardNumber.isEmpty ||
        state.creditCardExpiryDate.isEmpty ||
        state.creditCardCvv.isEmpty) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }
    if (state.selectedAddress == null) {
      return ValidationResult(false, message: AppText.errorAddressMustBeSelected.capitalizeFirstWord.get);
    }
    Log.test(data: state.creditCardNumber.clearSpaces);
    Log.test(data: state.creditCardNumber.clearSpaces.length);
    if (state.creditCardNumber.clearSpaces.length != 16) {
      return ValidationResult(false, message: AppText.errorInvalidCardNumber.capitalizeFirstWord.get);
    }

    return ValidationResult(true);
  }
}
