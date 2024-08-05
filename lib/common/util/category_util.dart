import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/product_exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

import '../../sddklibrary/helper/Log.dart';
import '../../data/model/category.dart';

class CategoryUtil {
   ResourceStatus<List<Category>> getNodeFromLastCategoryId(String lastCategoryId, List<List<Category>> categoriesByLayer) {
    try {
      List<Category> currentCategories = [];
      final lastIndex = categoriesByLayer.length - 1;
      Category? currentCategory;

      for (int index = lastIndex; index >= 0; index--) {
        for (Category category in categoriesByLayer[index]) {
          if (index == lastIndex) {
            if (category.id == lastCategoryId) {
              currentCategory = category;
              currentCategories.add(currentCategory);
              break;
            }
          } else {
            if (currentCategory == null) throw CategoryNotFoundException("Last category not found in last layer");
            if (category.id == currentCategory.superId) {
              currentCategory = category;
              currentCategories.add(currentCategory);
              break;
            }
          }
        }
      }
      return ResourceStatus.success(currentCategories.reversed.toList());
    } catch (exception, stackTrace) {
      if (exception is CategoryNotFoundException) {
        return ResourceStatus.fail(Fail(userMessage: AppText.errorLoadingCategories, exception: exception.message, stackTrace: stackTrace));
      } else {
        return ResourceStatus.fail(
            Fail(userMessage: AppText.errorLoadingCategories, exception: exception.toString(), stackTrace: stackTrace));
      }
    }
  }
}
