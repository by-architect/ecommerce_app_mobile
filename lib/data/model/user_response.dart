import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

class UserResponse extends User {
  final int? token;
  final String? accessToken;
  //final FirebaseAuth.User user;

  UserResponse(super.id, super.name, super.surname, super.email, super.password,
      super.phoneNo, this.token, this.accessToken);

  static UserResponse fromUser(User user,{ int? token, String? accessToken}) {
    return UserResponse(user.id, user.name, user.surname, user.email,
        user.password, user.phoneNo, token, accessToken);
  }
}
