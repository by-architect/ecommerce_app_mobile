import 'package:ecommerce_app_mobile/data/model/user_response.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

import '../model/user.dart';

class UserProvider {
  final UserService _service = UserServiceImpl();
  final UserService _fakeUserService= FakeUserService();

  void addUser(User user, String code,Function(Resource<UserResponse>) resource) async {
    resource(Resource.loading());
    await _service.addUser(user,code).then((userResource) => resource(userResource));
  }
  
  Future<void> sendEmailVerificationCode(User user, Function(Resource) resource) async {
    resource(Resource.loading());
    await _fakeUserService.sendEmailVerificationCode(user.email).then((responseResource) => resource(responseResource));
  }
}
