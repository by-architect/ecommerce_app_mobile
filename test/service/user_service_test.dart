import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
 test("userService_addUserTest", (){
  UserService userService = UserServiceImpl();
  userService.addUser(FakeUserModels.admin,"3243");
  expect(true, true) ;
 });
}