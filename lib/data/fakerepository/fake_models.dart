import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

import '../../presentation/authentication/bloc/user_state.dart';
import '../model/category.dart';

class FakeUserModels {
  static UserRequestState emin =
      UserRequestState(name: "emin", surname: "demir", email: "emindemir1541@proton.me", password: "testpassword");
  static UserRequestState test = UserRequestState(
    name: "test",
    surname: "test",
    email: "test",
    password: "test",
  );
  static UserRequestState admin = UserRequestState(
    name: "admin",
    surname: "admin",
    email: "admin@mail.com",
    password: "adminTest",
  );
  static UserRequestState testValidUser = UserRequestState(
    name: "admin",
    surname: "admin",
    email: "admin@mail.com",
    password: "adminTest",
  );
}

class FakeProductModels {
  static Category category1 = Category("0", "Elbiseler", "", 0);
  static Category category2 = Category("1", "Ayakkabılar", "", 0);
  static Category category21 = Category("12", "Sandalet", "1", 1);
  static Category category22 = Category("13", "Kundura", "1", 1);
  static Category category23 = Category("14", "Bot", "1", 1);
  static Category category231 = Category("15", "Deri Bot", "14", 2);
  static Category category3 = Category("2", "Bileklikler", "", 0);
  static Category category4 = Category("3", "Pantolonlar", "", 0);

  static final ProductFeatureOption _option1 = ProductFeatureOption("0", "Small");
  static final ProductFeatureOption _option2 = ProductFeatureOption("1", "Medium");
  static final ProductFeatureOption _option3 = ProductFeatureOption("2", "Large");

  static final ProductFeatureOption _option4 = ProductFeatureOption("3", "Blue");
  static final ProductFeatureOption _option5 = ProductFeatureOption("4", "Yellow");
  static final ProductFeatureOption _option6 = ProductFeatureOption("5", "Cyan");

  static ProductFeature productFeatureSize = ProductFeature(
    "0",
    "Size",
    [_option1, _option2, _option3],
    ProductFeatureType.text,
  );
  static ProductFeature productFeatureColor = ProductFeature("1", "Size", [_option4, _option5, _option6], ProductFeatureType.color);

  static Product product1 = Product("0", "Nike Ayakkabı", "1", "Mükemmel ayakkabı", 34.2, 5, "3204832", "0", 3, 54,
      [productFeatureSize.copyWith(selectedOption: _option1), productFeatureColor.copyWith(selectedOption: _option4)], 0);
  static Product product2 = Product("1", "Tuvalet", "0", "Gelinlik", 34.2, 6, "34905743", "0", 3, 54,
      [productFeatureSize.copyWith(selectedOption: _option2), productFeatureColor.copyWith(selectedOption: _option5)], 10);
}
