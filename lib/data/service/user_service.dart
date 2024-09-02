
import 'dart:async';

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../sddklibrary/util/resource.dart';
import '../model/user.dart';


abstract class UserService {
  Future<ResourceStatus<User>> addUser(UserRequestState userState);
  Future<ResourceStatus<User>> getUser();
  Future<ResourceStatus<User>> sendVerificationEmail(User user);
  bool isUserAuthenticated();
  Future<ResourceStatus<User>> signIn(UserRequestState userRequest); //if token not exist, sign in
  Future<ResourceStatus> signOut();
  Future<ResourceStatus> changePassword(User user,String oldPassword,String newPassword);
  Future<ResourceStatus<User>> changeUserSettings(User user);
  Future<ResourceStatus<User>> isEmailVerified();


}
