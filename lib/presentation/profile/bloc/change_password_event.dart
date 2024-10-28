
import '../../../data/model/user.dart';

class ChangePasswordEvent{}
class OldPasswordEvent extends ChangePasswordEvent{
  final String oldPassword;

  OldPasswordEvent(this.oldPassword);
}
class NewPasswordEvent extends ChangePasswordEvent{
  final String newPassword;

  NewPasswordEvent(this.newPassword);
}
class ConfirmPasswordEvent extends ChangePasswordEvent{
  final String confirmPassword;

  ConfirmPasswordEvent(this.confirmPassword);
}
class SaveEvent extends ChangePasswordEvent{
  final User user;

  SaveEvent(this.user);
}
