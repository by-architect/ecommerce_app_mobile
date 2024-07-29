

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';

import '../../model/user.dart';

class UserServiceEvent {}

class AddUserEvent extends UserServiceEvent {
  final UserRequestState user;
  AddUserEvent(this.user);
}
class LoginEvent extends UserServiceEvent{
  final UserRequestState user;

  LoginEvent(this.user);
}
class SendVerificationEmailEvent extends UserServiceEvent {
  final User user;

  SendVerificationEmailEvent(this.user);
}

class IsUserVerifiedEvent extends UserServiceEvent{}
class GetUserEvent extends UserServiceEvent{}
