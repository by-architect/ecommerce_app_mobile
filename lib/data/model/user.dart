import 'dart:ffi';

class User{
 final String name;
 final String surname;
 final String email;
 final String password;
 final String phoneNo;

 User(this.name, this.surname, this.email, this.password, this.phoneNo);

 @override
  String toString() {
    return 'User{name: $name, surname: $surname, email: $email, password: $password, phoneNo: $phoneNo}';
  }
}