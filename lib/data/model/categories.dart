import 'package:ecommerce_app_mobile/data/model/category_node.dart';

import '../../common/ui/theme/AppText.dart';
import '../../sddklibrary/constant/exceptions/product_exceptions.dart';
import '../../sddklibrary/helper/fail.dart';
import '../../sddklibrary/helper/resource.dart';
import 'category.dart';

class Categories {
  late final List<List<Category>> _list;

  Categories(List<Category> categoriesUnSorted) {
    _list = _sortCategoriesByLayer(categoriesUnSorted);
  }

  Categories.empty() {
    _list = [];
  }

  List<Category> get firstLayer => _list.first;
  List<Category> get lastLayer => _list.last;
  List<Category> getLayer(int layerId) => _list[layerId];

  bool get isEmpty => _list.isEmpty;
  int get layerCount => _list.length;

  List<List<Category>> _sortCategoriesByLayer(List<Category> categories) {
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

  static List<Category> getNextCategoryLayer(List<Category> nextLayerPool, Category selectedCategory) =>
      nextLayerPool.where((category) => category.superId == selectedCategory.id).toList();

  static List<Category> getPreviousCategoryLayer(List<Category> previousLayerPool, Category selectedCategory) => previousLayerPool.where((category) => category.id == selectedCategory.superId).toList();

  ResourceStatus<CategoryNode> getNodeFromLastCategoryId(String lastCategoryId) {
    try {
      List<Category> currentCategories = [];
      final lastIndex = _list.length - 1;
      Category? currentCategory;

      for (int index = lastIndex; index >= 0; index--) {
        for (Category category in _list[index]) {
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
      return ResourceStatus.success(CategoryNode(currentCategories.reversed.toList()));
    } catch (exception, stackTrace) {
      if (exception is CategoryNotFoundException) {
        return ResourceStatus.fail(Fail(userMessage: AppText.errorLoadingCategories, exception: exception, stackTrace: stackTrace));
      } else {
        return ResourceStatus.fail(Fail(userMessage: AppText.errorLoadingCategories, exception: exception, stackTrace: stackTrace));
      }
    }
  }

}
