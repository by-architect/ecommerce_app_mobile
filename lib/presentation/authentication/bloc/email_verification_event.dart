import '../../../data/model/user.dart';

class EmailVerificationEvent {}

class SendEmailVerificationEvent extends EmailVerificationEvent {
  final User user;

  SendEmailVerificationEvent(this.user);
}

class IsUserVerifiedEvent extends EmailVerificationEvent {}
