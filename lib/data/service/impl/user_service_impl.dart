import 'package:ecommerce_app_mobile/common/helper/Log.dart';
import 'package:ecommerce_app_mobile/common/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseLib;
import 'package:firebase_core/firebase_core.dart';

import '../../../firebase_options.dart';

class UserServiceImpl extends UserService {
  late final _firebaseAuth  =FirebaseLib.FirebaseAuth.instance;



  @override
  addUser(User user, Function(Resource<User>) resource) {
  }

  @override
  login(User user, Function(Resource<User>) resource) {
    var response = _firebaseAuth.signInWithEmailAndPassword(
        email: user.email, password: user.password);

    response.then((value) {
      Log.test(value.toString());
    });
  }
}
