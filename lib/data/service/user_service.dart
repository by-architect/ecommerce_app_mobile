import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../sddklibrary/helper/resource.dart';

abstract class UserService {
  Future<Resource<User>> addUser(UserState user);
  Future isEmailVerified(User user);
  Future<Resource> sendEmailVerificationCode(String email);


}
