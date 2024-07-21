import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServiceState {}

/*
class UserResponseState extends UserServiceState{
  final User userAuthCredentials;

  UserResponseState(this.userAuthCredentials);
}
*/

class AddUserInitState extends UserServiceState {}
class AddUserLoadingState extends UserServiceState{}
class AddUserSuccessState extends UserServiceState{
  final User user;
  AddUserSuccessState(this.user);
}
class AddUserFailState extends UserServiceState{
  final DefaultError error;
  AddUserFailState(this.error);
}

class SendVerificationCodeInitState extends UserServiceState{}
class SendVerificationCodeLoadingState extends UserServiceState{}
class SendVerificationCodeSuccessState extends UserServiceState{}
class SendVerificationCodeFailState extends UserServiceState{
  final DefaultError error;
  SendVerificationCodeFailState(this.error);
}

class EmailVerifiedState extends UserServiceState{}
class EmailNotVerifiedState extends UserServiceState{
}
class EmailVerificationFailState extends UserServiceState{
  final DefaultError error;
  EmailVerificationFailState(this.error);
}
