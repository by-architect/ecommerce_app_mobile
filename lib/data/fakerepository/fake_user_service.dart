import 'dart:math';

import 'package:ecommerce_app_mobile/data/model/user_response.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

class FakeUserService implements UserService {
  @override
  Future<Resource<UserResponse>> addUser(User user,String verificationCode) async {

    await Future.delayed(const Duration(seconds: 2));

    await verifyEmail(verificationCode);

/*
    for(int i = 0; i<5;i++){ Log.test("core test");
      await Future.delayed(const Duration(seconds: 1));
    }
*/
    var random = Random();
    return random.nextBool()
        ? Resource.success(UserResponse.fromUser(user, token: 32,accessToken: "sdlkfj"))
        : Resource.fail(DefaultError(userMessage: "Response fail situation",exception:" Response Fail situation" ),);
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

}
