import 'package:firebase_auth/firebase_auth.dart';

import 'user_response.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String password;
  final BigInt phoneNo;

  User(
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.phoneNo,
  );


  @override
  String toString() {
    return 'User{id: $id, name: $name, surname: $surname, email: $email, password: $password, phoneNo: ${phoneNo.toString()}}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'phoneNo': phoneNo.toString(),
    };
  }

  User copyWith(
      {String? id,
      String? name,
      String? surname,
      String? email,
      String? password,
      BigInt? phoneNo}) {
    return User(
      id ?? this.id,
      name ?? this.name,
      surname ?? this.surname,
      email ?? this.email,
      password ?? this.password,
      phoneNo ?? this.phoneNo,
    );
  }
}
