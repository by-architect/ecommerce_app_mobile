
import 'package:ecommerce_app_mobile/common/constant/Authority.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Helper.dart';

import '../../../common/constant/gender.dart';

class UserState {}

class UserRequestState extends UserState {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String passwordConfirm;
  final String birthYear;
  final Gender gender;

  // final String phoneNo;

  UserRequestState({
    this.name = "",
    this.surname = "",
    this.email = "",
    this.password = "",
    this.passwordConfirm = "",
    this.birthYear = "",
    this.gender = Gender.unselected,
  });

  UserRequestState copyWith(
      {String? name, String? surname, String? email, String? password, String? passwordConfirm, String? birthYear, Gender? gender}) {
    return UserRequestState(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        birthYear: birthYear ?? this.birthYear,
        gender: gender ?? this.gender);
  }

  Map<String, dynamic> toMap(String uid) {
    return {
      'id': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'birthYear': birthYear.toInt,
      'authority': Authority.user.name,
      'gender': gender.name
    };
  }

  @override
  String toString() {
    return 'UserRequestState{name: $name, surname: $surname, email: $email, password: $password, passwordConfirm: $passwordConfirm, birthYear: $birthYear, gender: $gender}';
  }
}
