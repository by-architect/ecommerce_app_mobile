

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';

class UserServiceEvent {}

class AddUserEvent extends UserServiceEvent {
  final UserState user;
  AddUserEvent(this.user);
}

class SendVerificationCodeEvent extends UserServiceEvent {
  final String email;

  SendVerificationCodeEvent(this.email);
}
