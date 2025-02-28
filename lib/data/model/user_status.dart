import 'package:ecommerce_app_mobile/data/model/user.dart';

class UserStatus{
 final User? user;
 bool get isAuthenticated => user != null;
 bool get isVerified => user?.firebaseUser!.emailVerified ?? false;

 UserStatus(this.user);
}