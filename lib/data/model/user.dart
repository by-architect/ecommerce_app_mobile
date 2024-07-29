import 'package:ecommerce_app_mobile/common/constant/gender.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Helper.dart';
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

  User(this.uid, this.name, this.surname, this.email, this.birthYear,this.gender, this.firebaseUser, this.userCredential);

  User.fromUserState(UserRequestState userState, this.firebaseUser, this.userCredential) {
    uid = firebaseUser.uid;
    name = userState.name;
    surname = userState.surname;
    email = firebaseUser.email ?? userState.email;
    birthYear = userState.birthYear.toInt;
    authority = Authority.user;
    gender = userState.gender;
  }

  User.fromMap(Map<String, dynamic> userMap, this.firebaseUser, {this.userCredential}) {
    uid = userMap['id'];
    name = userMap['name'];
    surname = userMap['surname'];
    email = userMap['email'];
    birthYear = userMap['birthYear'];
    authority =Authority.fromString(userMap['authority']);
    gender = Gender.fromString(userMap['gender']);
  }
}
