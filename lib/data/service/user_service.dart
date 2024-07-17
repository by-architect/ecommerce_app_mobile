import 'package:ecommerce_app_mobile/data/model/user_response.dart';

import '../../sddklibrary/helper/resource.dart';
import '../model/user.dart';

abstract class UserService {
  Future<Resource<UserResponse>> addUser(User user);

  login(User user, Function(Resource<User>) resource);
}
