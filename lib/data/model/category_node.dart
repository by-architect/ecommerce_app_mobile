import '../../sddklibrary/helper/Log.dart';
import 'category.dart';

class CategoryNode {
  late final List<Category> categories;

  CategoryNode.fromLastCategoryId(String lastCategoryId, List<List<Category>> categoriesByLayer) {
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
          if (category.id == currentCategory!.superId) {
            currentCategory = category;
            currentCategories.add(currentCategory);
            break;
          }
        }
      }
    }

    categories = currentCategories.reversed.toList();

/*
    Category currentCategory = categoriesByLayer[lastIndex].lastWhere((category) => category.id == lastCategoryId);
    Log.test(title: "current category",data: currentCategory.toString());
    currentCategories.add( currentCategory);

    for (int index = lastIndex; index >= 0; index--) {
      if (index != lastIndex) {
        currentCategory = categoriesByLayer[index].lastWhere((category) => category.id == currentCategory.superId);
        currentCategories.add(currentCategory);
      }
    }
    categories = currentCategories.reversed.toList();
*/
  }
}
