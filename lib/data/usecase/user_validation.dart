
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/validation_result.dart';


class UserValidation {
  static ValidationResult validate(UserRequestState userState) {
    if (userState.name.isEmpty || userState.surname.isEmpty || userState.email.isEmpty || userState.password.isEmpty || userState.phoneNo.isEmpty) {
      return ValidationResult(false, message: AppText.errorEmptyField);
    }
    if (!_isValidEmail(userState.email)) return ValidationResult(false, message: AppText.errorEmailIsNotValid);
    if (userState.password.length < 8 || userState.password.length > 16) {
      return ValidationResult(false, message: AppText.errorPasswordLength);
    }
    if (!_isValidPhoneNo(userState.phoneNo)) return ValidationResult(false, message: AppText.errorPhoneNoIsNotValid);

    return ValidationResult(true);
  }

  static bool _isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return regex.hasMatch(email);
  }

  static bool _isValidPhoneNo(String phoneNo) {
    try {
      final RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
      return regex.hasMatch(phoneNo.toLongPhone.toString());
    } catch (e) {
      return false;
    }
  }
}
