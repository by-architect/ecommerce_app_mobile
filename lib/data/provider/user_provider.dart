import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

import '../model/user.dart';


class UserProvider {
  final UserService _service = UserServiceImpl();
  // final UserService _fakeUserService= FakeUserService();

  void addUser(UserRequestState user,Function(Resource<User>) resource) async {
/*
    resource(Resource.loading());
    await _service.addUser(user).then((userResource) => resource(userResource));
*/
  //todo: not implemented
    throw UnimplementedError();
  }
  
  Future<void> sendEmailVerificationCode(UserRequestState user, Function(Resource) resource) async {
    resource(Resource.loading());
    // await _fakeUserService.sendVerificationEmail(user).then((responseResource) => resource(responseResource));
    throw UnimplementedError();
  }
}
