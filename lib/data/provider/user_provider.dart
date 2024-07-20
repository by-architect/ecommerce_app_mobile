import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserProvider {
  final UserService _service = UserServiceImpl();
  final UserService _fakeUserService= FakeUserService();

  void addUser(UserState user,Function(Resource<User>) resource) async {
    resource(Resource.loading());
    await _service.addUser(user).then((userResource) => resource(userResource));
  }
  
  Future<void> sendEmailVerificationCode(UserState user, Function(Resource) resource) async {
    resource(Resource.loading());
    await _fakeUserService.sendEmailVerificationCode(user.email).then((responseResource) => resource(responseResource));
  }
}
