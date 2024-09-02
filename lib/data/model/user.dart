import 'package:ecommerce_app_mobile/common/constant/gender.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../common/constant/authority.dart';

class User {
  late String uid;
  late String name;
  late String surname;
  late String email;
  late int birthYear;
  late Authority authority;
  late Gender gender;
  late firebase_auth.User firebaseUser;
  late firebase_auth.UserCredential? userCredential;

  User(this.uid, this.name, this.surname, this.email, this.birthYear, this.gender, this.firebaseUser,
      this.userCredential);

  User.test(
    this.uid,
    this.name,
    this.surname,
    this.email,
    this.birthYear,
    this.gender,
  ) {
    final testUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (testUser != null) {
      /// throws if firebase user is empty
      firebaseUser = testUser;
    }
    userCredential = null;
  }

  User.fromUserState(UserRequestState userState, this.firebaseUser, this.userCredential) {
    uid = firebaseUser.uid;
    name = userState.name;
    surname = userState.surname;
    email = firebaseUser.email ?? userState.email;
    birthYear = userState.birthYear.toInt;
    authority = Authority.user;
    gender = userState.gender;
  }

  UserState toUserState() {
    return UserState(
        name: name,
        surname: surname,
        email: email,
        password: "",
        birthYear: birthYear.toString(),
        gender: gender);
  }

  User.fromMap(Map<String, dynamic> userMap, this.firebaseUser, {this.userCredential}) {
    uid = userMap['id'];
    name = userMap['name'];
    surname = userMap['surname'];
    email = userMap['email'];
    birthYear = userMap['birthYear'];
    authority = Authority.fromString(userMap['authority']);
    gender = Gender.fromString(userMap['gender']);
  }

  @override
  String toString() {
    return 'User{uid: $uid, name: $name, surname: $surname, email: $email, birthYear: $birthYear, authority: $authority, gender: $gender, firebaseUser: $firebaseUser, userCredential: $userCredential}';
  }
}
