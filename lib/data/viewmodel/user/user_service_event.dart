import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';

import '../../model/user.dart';

class UserServiceEvent {}

class AddUserEvent extends UserServiceEvent {
  final User user;
  final String verificationCode;
  AddUserEvent(this.user,this.verificationCode);
}

class SendVerificationCodeEvent extends UserServiceEvent {
  final String email;

  SendVerificationCodeEvent(this.email);
}
