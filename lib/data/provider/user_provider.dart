import 'package:ecommerce_app_mobile/data/model/user_response.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';

import '../model/user.dart';

class UserProvider {
  UserService service = UserServiceImpl();

  void addUser(User user, Function(Resource<UserResponse>) resource) async {
    Resource.loading();
    await service.addUser(user).then((userResource) => resource(userResource));
  }
}
