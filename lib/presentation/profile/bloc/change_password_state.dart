import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';

import '../../../common/constant/gender.dart';
import '../../../sddklibrary/util/fail.dart';

class ChangePasswordState extends UserState {
  late final String oldPassword;
  late final String newPassword;
  late final String confirmPassword;

  ChangePasswordState(
      {required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.birthYear,
      required super.gender,
      required this.oldPassword,
      required this.newPassword,
      required this.confirmPassword});

  ChangePasswordState.load(UserState userState)
      : super(
            birthYear: userState.birthYear,
            gender: userState.gender,
            name: userState.name,
            email: userState.email,
            password: userState.password,
            surname: userState.surname) {
    oldPassword = "";
    newPassword = "";
    confirmPassword = "";
  }

  ChangePasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordState(
        birthYear: birthYear,
        gender: gender,
        name: name,
        email: email,
        password: password,
        surname: surname,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }

  UserState asUserState() {
    return UserState(
        name: name,
        surname: surname,
        email: email,
        password: newPassword,
        birthYear: birthYear,
        gender: gender);
  }
}

class InitChangePasswordState extends ChangePasswordState {
  InitChangePasswordState()
      : super(
            birthYear: "",
            gender: Gender.unselected,
            name: "",
            email: "",
            password: "",
            surname: "",
            confirmPassword: "",
            newPassword: "",
            oldPassword: "");
}

class ChangePasswordSuccessState extends ChangePasswordState {
  ChangePasswordSuccessState(
      {required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.birthYear,
      required super.gender,
      required super.oldPassword,
      required super.newPassword,
      required super.confirmPassword});
}

class ChangePasswordFailState extends ChangePasswordState {
  final Fail fail;

  ChangePasswordFailState(
      {required this.fail,
      required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.birthYear,
      required super.gender,
      required super.oldPassword,
      required super.newPassword,
      required super.confirmPassword});
}

class ChangePasswordLoadingState extends ChangePasswordState {
  ChangePasswordLoadingState(
      {required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.birthYear,
      required super.gender,
      required super.oldPassword,
      required super.newPassword,
      required super.confirmPassword});
}
