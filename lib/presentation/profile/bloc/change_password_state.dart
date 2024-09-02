
import '../../../sddklibrary/util/fail.dart';

class ChangePasswordState {
  late final String oldPassword;
  late final String newPassword;
  late final String confirmPassword;

  ChangePasswordState(
      {required this.oldPassword, required this.newPassword, required this.confirmPassword});

  ChangePasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordState(
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }
}

class InitChangePasswordState extends ChangePasswordState {
  InitChangePasswordState() : super(confirmPassword: "", newPassword: "", oldPassword: "");
}

class ChangePasswordSuccessState extends ChangePasswordState {
  ChangePasswordSuccessState(
      {required super.oldPassword, required super.newPassword, required super.confirmPassword});
}

class ChangePasswordFailState extends ChangePasswordState {
  final Fail fail;

  ChangePasswordFailState(
      {required this.fail,
      required super.oldPassword,
      required super.newPassword,
      required super.confirmPassword});
}

class ChangePasswordLoadingState extends ChangePasswordState {
  ChangePasswordLoadingState(
      {required super.oldPassword, required super.newPassword, required super.confirmPassword});
}
