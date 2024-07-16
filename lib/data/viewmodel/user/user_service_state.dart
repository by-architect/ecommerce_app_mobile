import 'package:ecommerce_app_mobile/common/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';

class UserServiceState {
Resource<User> userData;
  UserServiceState({required this.userData});
}

class InitUserServiceState extends UserServiceState{
  InitUserServiceState():super(userData: Resource.loading());
}