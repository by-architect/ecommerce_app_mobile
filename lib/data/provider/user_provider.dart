import 'package:ecommerce_app_mobile/common/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

import '../model/user.dart';

class UserProvider {
  UserService service = FakeUserService();

  addUser(User user,Function(Resource<User>) resource) async {
    await service.addUser(user,resource);
  }
}
