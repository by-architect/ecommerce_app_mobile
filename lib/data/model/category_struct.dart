import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category_node.dart';

import 'category.dart';

class CategoryStruct {
  late final Categories _categories;
  late final List<List<Category>> _categoryListNode;
  late final CategoryNode categoryNode;

  int get currentLayerId => _categoryListNode.length - 1;

  List<Category> get currentLayer => _categoryListNode.last;

  String get title => categoryNode.nodeString;

  bool get isFirstLayer => currentLayerId == 0;

  Category get selectedCategory => categoryNode.last;

   get _sort {
    _categoryListNode.last.sort((Category a, Category b) => isLastLayer(a) ? 1 : -1);
  }

  CategoryStruct.empty() {
    _categoryListNode = [];
    _categories = Categories.empty();
    categoryNode = CategoryNode.empty();
  }

  CategoryStruct(this._categories) {
    _categoryListNode = [_categories.firstLayer];
    categoryNode = CategoryNode.empty();
    _sort;
  }

  bool isLastLayer(Category selectedCategory) {
    if (_categories.layerCount <= currentLayerId + 1) {
      return true;
    } else {
      return _categories.getLayer(currentLayerId + 1).where((category) => category.superId == selectedCategory.id).toList().isEmpty;
    }
  }

  nextLayer(Category selectedCategory) {
    final nextLayer = _categories.getLayer(currentLayerId + 1).where((category) => category.superId == selectedCategory.id).toList();
    _categoryListNode.add(nextLayer);
    categoryNode.add(selectedCategory);
    _sort;
  }

  previousLayer() {
    _categoryListNode.removeLast();
    categoryNode.removeLast();
  }

  @override
  String toString() {
    return 'CategoryStruct{_categories: $_categories, _categoryListNode: $_categoryListNode, categoryNode: $categoryNode,}';
  }

/*
  previousLayer(int previousLayerId, Category selectedCategory) {
    _categoryListNode.add(_categories.getLayer(previousLayerId).where((category) => category.id == selectedCategory.superId).toList());
  }
*/
}
