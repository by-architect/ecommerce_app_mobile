import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/usecase/validation_base.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/validation_result.dart';

import '../../common/constant/gender.dart';

class UserValidation {
  static ValidationResult validateRegistration(SignUpState state) {
    if (state.name.isEmpty ||
        state.surname.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.birthYear.isEmpty ||
        state.gender == Gender.unselected) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }

    if (state.password != state.passwordConfirm) {
      return ValidationResult(false, message: AppText.errorPasswordsAreNotMatching.capitalizeFirstWord.get);
    }
    if (!ValidationBase.isValidEmail(state.email)) {
      return ValidationResult(false, message: AppText.errorEmailIsNotValid.capitalizeFirstWord.get);
    }
    if (state.password.length < 8 || state.password.length > 16) {
      return ValidationResult(false, message: AppText.errorPasswordLength.capitalizeFirstWord.get);
    }
    if (!state.birthYear.isDigit) {
      return ValidationResult(false, message: AppText.errorBirthYearIsNotValid.capitalizeFirstWord.get);
    }
    if (state.birthYear.toInt < 1900 || state.birthYear.toInt > DateTime.now().year - 5) {
      return ValidationResult(false, message: AppText.errorBirthYearIsNotValid.capitalizeFirstWord.get);
    }
    // if (!_isValidPhoneNo(userState.phoneNo)) return ValidationResult(false, message: AppText.errorPhoneNoIsNotValid);

    return ValidationResult(true);
  }

  static ValidationResult validateLogin(SignInState userState) {
    if (userState.email.isEmpty || userState.password.isEmpty) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }
    if (!ValidationBase.isValidEmail(userState.email)) {
      return ValidationResult(false, message: AppText.errorEmailIsNotValid.capitalizeFirstWord.get);
    }
    if (userState.password.length < 8 || userState.password.length > 16) {
      return ValidationResult(false, message: AppText.errorPasswordLength.capitalizeFirstWord.get);
    }
    return ValidationResult(true);
  }



  static ValidationResult validateProfileEdition(EditProfileState userState) {
    if (userState.name.isEmpty ||
        userState.surname.isEmpty ||
        userState.birthYear.isEmpty ||
        userState.gender == Gender.unselected) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }

    if (!userState.birthYear.isDigit) {
      return ValidationResult(false, message: AppText.errorBirthYearIsNotValid.capitalizeFirstWord.get);
    }
    if (userState.birthYear.toInt < 1900 || userState.birthYear.toInt > DateTime.now().year - 5) {
      return ValidationResult(false, message: AppText.errorBirthYearIsNotValid.capitalizeFirstWord.get);
    }
    // if (!_isValidPhoneNo(userState.phoneNo)) return ValidationResult(false, message: AppText.errorPhoneNoIsNotValid);

    return ValidationResult(true);
  }

  static ValidationResult validateChangePassword(ChangePasswordState state) {
    if (state.oldPassword.isEmpty || state.newPassword.isEmpty || state.confirmPassword.isEmpty) {
      return ValidationResult(false, message: AppText.errorEmptyField.capitalizeFirstWord.get);
    }
    if (state.newPassword != state.confirmPassword) {
      return ValidationResult(false, message: AppText.errorPasswordsAreNotMatching.capitalizeFirstWord.get);
    }
    if (state.newPassword.length < 8 || state.newPassword.length > 16) {
      return ValidationResult(false, message: AppText.errorPasswordLength.capitalizeFirstWord.get);
    }
    return ValidationResult(true);
  }
}
