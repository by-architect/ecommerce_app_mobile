import 'dart:isolate';
import 'dart:math';

import 'package:ecommerce_app_mobile/data/model/user_response.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

class FakeUserService implements UserService {
  @override
  Future<Resource<UserResponse>> addUser(User user) async {

    await Future.delayed(const Duration(seconds: 2));

/*
    for(int i = 0; i<5;i++){ Log.test("core test");
      await Future.delayed(const Duration(seconds: 1));
    }
*/
    var random = Random();
    return random.nextBool()
        ? Resource.success(UserResponse.fromUser(user, 3, ""))
        : Resource.fail("Test response fail situation");
  }

  @override
  login(User user, Function(Resource<User>) resource) {}
}
