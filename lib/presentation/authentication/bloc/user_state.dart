

class UserState {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String phoneNo;

  UserState({this.name = "", this.surname = "", this.email = "", this.password = "", this.phoneNo = ""});

  UserState copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? phoneNo,
}) {
    return UserState(
      name: name??this.name,
      surname: surname??this.surname,
      email: email??this.email,
      password: password??this.password,
      phoneNo: phoneNo??this.phoneNo
    );
  }
  Map<String, dynamic> toMap(String uid) {
    return {
      'id': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'phoneNo': phoneNo,
    };
  }
}
