import 'package:ecommerce_app_mobile/common/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

class FakeUserService implements UserService {
  @override
  addUser(User user,Function(Resource<User>) resource) async{
    resource(Resource.loading());
    await Future.delayed(const Duration(seconds: 5));
    resource(Resource.success(FakeUserModels.emin));
  }

  @override
  login(User user, Function(Resource<User>) resource) {
  }
}
