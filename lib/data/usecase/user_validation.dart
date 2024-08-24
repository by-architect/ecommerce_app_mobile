import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/validation_result.dart';

import '../../common/constant/gender.dart';

class UserValidation {
  static ValidationResult validateRegistration(UserRequestState userState) {
    if (userState.name.isEmpty ||
        userState.surname.isEmpty ||
        userState.email.isEmpty ||
        userState.password.isEmpty ||
        userState.birthYear.isEmpty ||
        userState.gender == Gender.unselected) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord);
    }

    if (userState.password != userState.passwordConfirm) return ValidationResult(false, message: AppText.errorPasswordsAreNotMatching.capitalizeFirstWord);
    if (!_isValidEmail(userState.email)) return ValidationResult(false, message: AppText.errorEmailIsNotValid.capitalizeFirstWord);
    if (userState.password.length < 8 || userState.password.length > 16)
      return ValidationResult(false, message: AppText.errorPasswordLength.capitalizeFirstWord);
    if (!userState.birthYear.isDigit) return ValidationResult(false, message: AppText.errorBirthYearIsNotValid.capitalizeFirstWord);
    if (userState.birthYear.toInt < 1900 || userState.birthYear.toInt > DateTime.now().year - 5)
      return ValidationResult(false, message: AppText.errorBirthYearIsNotValid.capitalizeFirstWord);
    // if (!_isValidPhoneNo(userState.phoneNo)) return ValidationResult(false, message: AppText.errorPhoneNoIsNotValid);

    return ValidationResult(true);
  }

  static ValidationResult validateLogin(UserRequestState userState) {
    if (userState.email.isEmpty || userState.password.isEmpty) return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord);
    if (!_isValidEmail(userState.email)) return ValidationResult(false, message: AppText.errorEmailIsNotValid.capitalizeFirstWord);
    if (userState.password.length < 8 || userState.password.length > 16) {
      return ValidationResult(false, message: AppText.errorPasswordLength.capitalizeFirstWord);
    }
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
