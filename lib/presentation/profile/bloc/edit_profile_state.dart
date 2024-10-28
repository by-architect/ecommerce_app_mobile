import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/constant/gender.dart';
import '../../../data/model/user.dart';
import '../../../sddklibrary/util/fail.dart';

class EditProfileState {
  final String name;
  final String surname;
  final String birthYear;
  final Gender gender;

  EditProfileState({required this.name, required this.surname, required this.birthYear, required this.gender});

  Map<String, dynamic> toMap(String uid) {
    return {
      'id': uid,
      'name': StringHelper.capitalizeEveryWord(name),
      'surname': StringHelper.capitalizeEveryWord(surname),
      'birthYear': birthYear.toInt,
      'gender': gender.name
    };
  }

  EditProfileState copyWith({String? name, String? surname, String? birthYear, Gender? gender}) {
    return EditProfileState(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        birthYear: birthYear ?? this.birthYear,
        gender: gender ?? this.gender);
  }
}

class EditProfileInitState extends EditProfileState {
  EditProfileInitState() : super(birthYear: "", gender: Gender.unselected, name: "", surname: "");
}

class EditProfileSuccessState extends EditProfileState {
  final User user;
  EditProfileSuccessState(
      {required this.user,required super.name, required super.surname, required super.birthYear, required super.gender});
}

class EditProfileFailState extends EditProfileState {
  final Fail fail;

  EditProfileFailState(
      {required this.fail,
      required super.name,
      required super.surname,
      required super.birthYear,
      required super.gender});
}

class EditProfileLoadingState extends EditProfileState {
  EditProfileLoadingState(
      {required super.name, required super.surname, required super.birthYear, required super.gender});
}
