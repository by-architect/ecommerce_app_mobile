import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/product_exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

import '../../data/model/category.dart';

class CategoryUtil {
  List<List<Category>> sortCategoriesByLayer(List<Category> categories) {
    final List<List<Category>> categoriesByLayer = [];
    for (int layer = 0;; layer++) {
      final categoryLayer = categories.where((category) {
        return category.layer == layer;
      }).toList();
      if (categoryLayer.isEmpty) break;
      categoriesByLayer.insert(layer, categoryLayer);
    }
    return categoriesByLayer;
  }

  List<Category> getNextCategoryLayer(List<Category> nextLayerPool, Category selectedCategory) {
    final categoriesLayer = nextLayerPool.where((category) => category.superId == selectedCategory.id).toList();
    return categoriesLayer;
  }

  List<Category> getPreviousCategoryLayer(List<Category> previousLayerPool, Category selectedCategory) {
    final categoriesLayer = previousLayerPool.where((category) => category.id == selectedCategory.superId).toList();
    return categoriesLayer;
  }

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
        return ResourceStatus.fail(Fail(userMessage: AppText.errorLoadingCategories, exception: exception, stackTrace: stackTrace));
      } else {
        return ResourceStatus.fail(
            Fail(userMessage: AppText.errorLoadingCategories, exception: exception, stackTrace: stackTrace));
      }
    }
  }

  String categoryNodeToString(List<Category> categoryNode) {
    String nodeString = "";
    categoryNode.forEach((category) {
      if (nodeString.isEmpty) {
        nodeString = category.name;
      } else {
        nodeString = " $nodeString > ${category.name}";
      }
    });
    return nodeString;
  }
}
