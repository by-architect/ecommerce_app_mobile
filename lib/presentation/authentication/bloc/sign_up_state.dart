import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../common/constant/authority.dart';
import '../../../common/constant/gender.dart';
import '../../../data/model/user.dart';
import '../../../sddklibrary/helper/string_helper.dart';

class SignUpState {

  final String name;
  final String surname;
  final String email;
  final String password;
  final String birthYear;
  final Gender gender;
  final String passwordConfirm;

  SignUpState({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.birthYear,
    required this.gender
  });

  SignUpState copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? passwordConfirm,
    String? birthYear,
    Gender? gender
  }) {
    return SignUpState(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        birthYear: birthYear ?? this.birthYear,
        gender: gender ?? this.gender
    );
  }

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

class SignUpInitState extends SignUpState {
  SignUpInitState() : super(
      name: '',
      surname: '',
      email: '',
      password: '',
      passwordConfirm: '',
      birthYear: '',
      gender: Gender.unselected
  );
}
class SignUpRequestLoadingState extends SignUpState {
  final SignUpState state;

  SignUpRequestLoadingState(this.state) : super(
      name: state.name,
      surname: state.surname,
      email: state.email,
      password: state.password,
      passwordConfirm: state.passwordConfirm,
      birthYear: state.birthYear,
      gender: state.gender
  );

}
class SignUpRequestSuccessState extends SignUpState {
  final SignUpState state;
  final User user;

  SignUpRequestSuccessState({required this.state, required this.user}) : super(
      name: state.name,
      surname: state.surname,
      email: state.email,
      password: state.password,
      passwordConfirm: state.passwordConfirm,
      birthYear: state.birthYear,
      gender: state.gender
  );

}

class SignUpRequestFailState extends SignUpState {
  final SignUpState state;
  final Fail fail;

  SignUpRequestFailState({required this.state, required this.fail}) : super(
      name: state.name,
      surname: state.surname,
      email: state.email,
      password: state.password,
      passwordConfirm: state.passwordConfirm,
      birthYear: state.birthYear,
      gender: state.gender
  );

}