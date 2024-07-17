import 'package:flutter/services.dart';

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

class PhoneNoEvent extends UserEvent{
  final String phoneNo;

  PhoneNoEvent(this.phoneNo);
}