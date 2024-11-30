import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/validation_result.dart';

import '../../common/ui/theme/AppText.dart';
import '../model/return_process.dart';

class ReturnRequestValidation {
  static ValidationResult validate(ReturnDetailsState state) {
    if (state.returnType == ReturnType.unselected) {
      return ValidationResult(false,
          message: AppText.errorSelectReason.capitalizeFirstWord.get);
    }
    if (state.returnReason.isEmpty) {
      return ValidationResult(false,
          message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }
    if (state.products.isEmpty) {
      return ValidationResult(false,
          message: AppText.errorSelectProduct.capitalizeFirstWord.get);
    }
    return ValidationResult(true);
  }
}
