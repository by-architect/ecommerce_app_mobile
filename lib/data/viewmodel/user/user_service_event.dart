

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServiceEvent {}

class AddUserEvent extends UserServiceEvent {
  final UserRequestState user;
  AddUserEvent(this.user);
}

class SendVerificationCodeEvent extends UserServiceEvent {
  final User user;

  SendVerificationCodeEvent(this.user);
}

class IsUserVerifiedEvent extends UserServiceEvent{
}