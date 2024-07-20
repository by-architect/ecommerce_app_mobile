import 'package:ecommerce_app_mobile/data/model/user_response.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';

class UserServiceState {}

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
