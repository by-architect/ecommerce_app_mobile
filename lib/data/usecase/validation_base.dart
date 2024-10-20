import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';

class ValidationBase{

  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return regex.hasMatch(email);
  }
  static bool isValidPhoneNo(String phoneNo) {
    try {
      final RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
      return regex.hasMatch(phoneNo.toLongPhone.toString());
    } catch (e) {
      return false;
    }
  }

}