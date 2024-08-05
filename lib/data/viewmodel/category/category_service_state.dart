import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';

import '../../model/category.dart';

class CategoryServiceState {
  final List<List<Category>> categories;

  CategoryServiceState(this.categories);
}

class GetCategoriesByLayerInitState extends CategoryServiceState {
  GetCategoriesByLayerInitState() : super([]);
}

class GetCategoriesByLayerLoadingState extends CategoryServiceState {
  GetCategoriesByLayerLoadingState() : super([]);
}

class GetCategoriesByLayerSuccessState extends CategoryServiceState {
  GetCategoriesByLayerSuccessState(super.categories);
}

class GetCategoriesByLayerFailState extends CategoryServiceState {
  final Fail error;

  GetCategoriesByLayerFailState(this.error) : super([]);
}
