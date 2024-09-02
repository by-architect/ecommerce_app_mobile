import 'package:ecommerce_app_mobile/common/constant/authority.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';

import '../../../common/constant/gender.dart';

class UserState {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String birthYear;
  final Gender gender;

  // final String phoneNo;

  UserState(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.birthYear,
      required this.gender});

  Map<String, dynamic> toMap(String uid) {
    return {
      'id': uid,
      'name': StringHelper.capitalizeEveryWord(name),
      'surname': StringHelper.capitalizeEveryWord(surname),
      'email': email,
      'password': password,
      'birthYear': birthYear.toInt,
      'authority': Authority.user.name,
      'gender': gender.name
    };
  }
}

class UserRequestState extends UserState {
  final String passwordConfirm;

  UserRequestState(
      {required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.birthYear,
      required super.gender,
      required this.passwordConfirm});

  UserRequestState copyWith(
      {String? name,
      String? surname,
      String? email,
      String? password,
      String? passwordConfirm,
      String? birthYear,
      Gender? gender}) {
    return UserRequestState(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        birthYear: birthYear ?? this.birthYear,
        gender: gender ?? this.gender);
  }


  @override
  String toString() {
    return 'UserRequestState{name: $name, surname: $surname, email: $email, password: $password, passwordConfirm: $passwordConfirm, birthYear: $birthYear, gender: $gender}';
  }
}

class InitUserRequestState extends UserRequestState{
  InitUserRequestState(): super(surname: "",name: "",password: "",email: "",gender: Gender.unselected, birthYear: "",passwordConfirm: "");

}


