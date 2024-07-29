
import 'dart:async';

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../sddklibrary/helper/resource.dart';
import '../model/user.dart';


abstract class UserService {
  Future<Resource<User>> addUser(UserRequestState userState);
  Future<Resource<User>> getUser();
  Future<Resource<User>> sendVerificationEmail(User user);
  bool isUserAuthenticated();
  Future<Resource<User>> signIn(UserRequestState userRequest); //if token not exist, sign in
  Future<Resource> signOut();
  Future<Resource> changePassword(User user);
  Future<Resource<User>> changeUserSettings(User user);
  Future<Resource<User>> isEmailVerified();


}
