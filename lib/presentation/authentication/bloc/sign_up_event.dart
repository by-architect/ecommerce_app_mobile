import '../../../common/constant/gender.dart';

class SignUpEvent {}

class NameEvent extends SignUpEvent {
  final String name;

  NameEvent(this.name);
}

class SurnameEvent extends SignUpEvent {
  final String surname;

  SurnameEvent(this.surname);
}

class EmailEvent extends SignUpEvent {
  final String email;

  EmailEvent(this.email);
}

class PasswordEvent extends SignUpEvent {
  final String password;

  PasswordEvent(this.password);
}

class PasswordConfirmEvent extends SignUpEvent {
  final String passwordConfirm;

  PasswordConfirmEvent(this.passwordConfirm);
}

class BirthYearEvent extends SignUpEvent {
  final String birthYear;

  BirthYearEvent(this.birthYear);
}

class GenderEvent extends SignUpEvent {
  final Gender gender;

  GenderEvent(this.gender);
}

class SignUpRequestEvent extends SignUpEvent {}

