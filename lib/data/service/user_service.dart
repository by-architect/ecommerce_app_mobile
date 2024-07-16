

import '../../common/helper/resource.dart';
import '../model/user.dart';

abstract class UserService {
   addUser(User user,Function(Resource<User>) resource);

}
