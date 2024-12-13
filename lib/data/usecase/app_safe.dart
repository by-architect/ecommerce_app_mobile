import 'package:ecommerce_app_mobile/data/model/categories.dart';

import '../model/category.dart';

class AppSafe {
  static bool isAppSafe(Categories categories) {
    return isCategoriesSafe(categories);
  }

  static bool isCategoriesSafe(Categories categories) {
    return categories.length > 3 || categories.length < 30;
  }
}
