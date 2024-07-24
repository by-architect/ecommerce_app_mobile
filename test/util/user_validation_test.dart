import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test("userValidation_validateUser_validUser", () {
    var user = FakeUserModels.testValidUser;
    var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
    var validation = UserValidation.validate(userState);
    Log.debug("user_validation:", validation.message);
    expect(validation.success, true);
  });
    test("userValidation_validateUser_mistakenEmail", () {
      var user = FakeUserModels.testValidUser.copyWith(email: "mistakenmail");
      var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
      var validation = UserValidation.validate(userState);
      Log.debug("user_validation:", validation.message);
      expect(validation.success, false);
    });
    test("userValidation_validateUser_longPassword", () {
      var user = FakeUserModels.testValidUser.copyWith(password: "223984579238w7598324759882347593257892353");
      var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
      var validation = UserValidation.validate(userState);
      Log.debug("user_validation:", validation.message);
      expect(validation.success, false);
    });
    test("userValidation_validateUser_shortPassword", () {
      var user = FakeUserModels.testValidUser.copyWith(password: "23");
      var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
      var validation = UserValidation.validate(userState);
      Log.debug("user_validation:", validation.message);
      expect(validation.success, false);
    });

  test("userValidation_validateUser_invalidPhone", () {
    var user = FakeUserModels.testValidUser;
    var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
    var validation = UserValidation.validate(userState);
    Log.debug("user_validation:", validation.message);
    expect(validation.success, false);
  });
    test("userValidation_validateUser_validPhone", () {
      var user = FakeUserModels.testValidUser;
      var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
      var validation = UserValidation.validate(userState);
      Log.debug("user_validation:", validation.message);
      expect(validation.success, true);
    });
    test("userValidation_validateUser_emptyField", () {
      var user = FakeUserModels.testValidUser.copyWith(surname: "");
      var userState = UserRequestState(name: user.name,surname: user.surname,email: user.email,password: user.password,);
      var validation = UserValidation.validate(userState);
      Log.debug("user_validation:", validation.message);
      expect(validation.success, false);
    });

}
