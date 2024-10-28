
import 'dart:async';

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../sddklibrary/util/resource.dart';
import '../model/user.dart';


abstract class UserService {
  Future<ResourceStatus<User>> addUser(SignUpState signUpState);
  Future<ResourceStatus<User>> getUser();
  Future<ResourceStatus<User>> sendVerificationEmail(User user);
  bool isUserAuthenticated();
  Future<ResourceStatus<User>> signIn(SignInState signInState); //if token not exist, sign in
  Future<ResourceStatus> signOut();
  Future<ResourceStatus> changePassword(User user,ChangePasswordState state);
  Future<ResourceStatus<User>> editUserSettings(User user,EditProfileState userState);
  Future<ResourceStatus<User>> isEmailVerified();


}
