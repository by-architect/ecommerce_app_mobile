import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServiceState {}


class UserServiceSuccessState extends UserServiceState {
  final User user;
  UserServiceSuccessState(this.user);
}
class UserServiceFailState extends UserServiceState{
  final DefaultError error;
  UserServiceFailState(this.error);
}


class AddUserInitState extends UserServiceState {}
class AddUserLoadingState extends UserServiceState {}
class AddUserSuccessState extends UserServiceSuccessState {
  AddUserSuccessState(super.user);
}
class AddUserFailState extends UserServiceFailState {
  AddUserFailState(super.error);
}

class SendVerificationCodeInitState extends UserServiceState {}
class SendVerificationCodeLoadingState extends UserServiceState {}
class SendVerificationCodeSuccessState extends UserServiceState {}
class SendVerificationCodeFailState extends UserServiceFailState {
  SendVerificationCodeFailState(super.error);
}

class EmailVerifiedState extends UserServiceSuccessState {
  EmailVerifiedState(super.user);
}
class EmailNotVerifiedState extends UserServiceState {}
class EmailVerificationFailState extends UserServiceFailState {
  EmailVerificationFailState(super.error);
}


class GetUserSuccessState extends UserServiceSuccessState {
  GetUserSuccessState(super.user);
}
class GetUserFailState extends UserServiceFailState {
  GetUserFailState(super.error);
}
class GetUserLoadingState extends UserServiceState {}
