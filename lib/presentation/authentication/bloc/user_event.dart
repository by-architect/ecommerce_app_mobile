import 'package:flutter/services.dart';

import '../../../common/constant/gender.dart';

class UserEvent {}

class NameEvent extends UserEvent {
  final String name;
  NameEvent(this.name);
}

class SurnameEvent extends UserEvent {
  final String surname;

  SurnameEvent(this.surname);
}

class EmailEvent extends UserEvent {
  final String email;

  EmailEvent(this.email);
}

class PasswordEvent extends UserEvent {
  final String password;

  PasswordEvent(this.password);
}
class PasswordConfirmEvent extends UserEvent{
  final String passwordConfirm;

  PasswordConfirmEvent(this.passwordConfirm);
}

class PhoneNoEvent extends UserEvent{
  final String phoneNo;

  PhoneNoEvent(this.phoneNo);
}

class GenderEvent extends UserEvent{
  final Gender gender;

  GenderEvent(this.gender);
}
class BirthYearEvent extends UserEvent{
  final String birthYear;

  BirthYearEvent(this.birthYear);
}