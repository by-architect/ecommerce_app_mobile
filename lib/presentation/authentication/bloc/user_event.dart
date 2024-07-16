import 'package:flutter/services.dart';

class UserEvent {}

class AddName extends UserEvent {
  final String name;

  AddName(this.name);
}

class AddSurname extends UserEvent {
  final String surname;

  AddSurname(this.surname);
}

class AddEmail extends UserEvent {
  final String email;

  AddEmail(this.email);
}

class AddPassword extends UserEvent {
  final String password;

  AddPassword(this.password);
}

class AddPhoneNo extends UserEvent{
  final String phoneNo;

  AddPhoneNo(this.phoneNo);
}