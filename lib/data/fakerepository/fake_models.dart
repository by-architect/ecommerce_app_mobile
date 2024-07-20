import 'package:ecommerce_app_mobile/data/model/user.dart';

class FakeUserModels{
  static User emin = User("234","emin", "demir", "emindemir1541@proton.me", "testpassword",BigInt.from(324324));
  static User test = User("324","test", "test", "test", "test",BigInt.from(353452)  );

  static User admin = User("sdfl","admin", "admin", "admin@mail.com", "adminTest", BigInt.from(353452));

  static User testValidUser = User("32432srdf","admin", "admin", "admin@mail.com", "adminTest", BigInt.from(5556473748));

}