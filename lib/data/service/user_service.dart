import 'package:ecommerce_app_mobile/data/model/user_response.dart';

import '../../sddklibrary/helper/resource.dart';
import '../model/user.dart';

abstract class UserService {
  Future<Resource<UserResponse>> addUser(User user,String verificationCode);
  Future verifyEmail(String code);
  Future<Resource> sendEmailVerificationCode(String email);


}
