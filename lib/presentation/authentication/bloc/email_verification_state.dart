import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../data/model/user.dart';

class EmailVerificationState {
}

class InitialEmailVerificationState extends EmailVerificationState {
}

class VerificationLinkSendSuccessState extends EmailVerificationState {

}

class VerificationLinkSendFailState extends EmailVerificationState {

  final Fail fail;
  VerificationLinkSendFailState(this.fail);
}
class EmailVerifiedState extends EmailVerificationState {
  final User user;

  EmailVerifiedState(this.user);
}
class EmailNotVerifiedState extends EmailVerificationState {}

class EmailVerificationFailState extends EmailVerificationState {
  final Fail fail;

  EmailVerificationFailState(this.fail);
}