import '../../../common/constant/gender.dart';
import '../../../data/model/user.dart';

class EditProfileEvent {}

class UpdateEvent extends EditProfileEvent {
  final User user;

  UpdateEvent(this.user);
}
class LoadUserEvent extends EditProfileEvent {
  final User user;

  LoadUserEvent(this.user);
}

class NameEvent extends EditProfileEvent {
  final String name;

  NameEvent(this.name);
}

class SurnameEvent extends EditProfileEvent {
  final String surname;

  SurnameEvent(this.surname);
}

/*
class EmailEvent extends EditProfileEvent {
  final String email;

  EmailEvent(this.email);
}
*/

class GenderEvent extends EditProfileEvent {
  final Gender gender;

  GenderEvent(this.gender);
}

class BirthYearEvent extends EditProfileEvent {
  final String birthYear;

  BirthYearEvent(this.birthYear);
}
