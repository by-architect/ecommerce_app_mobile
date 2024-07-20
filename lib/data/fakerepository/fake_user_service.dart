import 'dart:math';

import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FakeUserService implements UserService {
  @override
  Future<Resource<User>> addUser(UserState user) async {

    await Future.delayed(const Duration(seconds: 2));

/*
    for(int i = 0; i<5;i++){ Log.test("core test");
      await Future.delayed(const Duration(seconds: 1));
    }
*/
    var random = Random();
    return Resource.fail(DefaultError(userMessage: "Cant return firebase user so",exception:"" ),);
  }

  @override
  Future<Resource> verifyEmail(String code) async {
   await Future.delayed(const Duration(seconds: 2)) ;

   var random = Random();
   return random.nextBool()
       ? Resource.success(code)
       : Resource.fail(DefaultError(userMessage: "wrong code",exception:"" ),);
  }

  @override
  Future<Resource> sendEmailVerificationCode(String email) async {
    await Future.delayed(const Duration(seconds: 4));

    var random = Random();
    return random.nextBool()
        ? Resource.success("Success")
        : Resource.fail(DefaultError(userMessage: "fail",exception: "fail"));
  }

  @override
  Future isEmailVerified(User user) {
    // TODO: implement isEmailVerified
    throw UnimplementedError();
  }

}
