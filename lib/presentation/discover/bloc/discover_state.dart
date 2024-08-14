import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/util/category_util.dart';

import '../../../data/model/category.dart';
import '../../../sddklibrary/helper/fail.dart';

class DiscoverState {
  final List<List<Category>> categoriesByLayer;
  final List<Category> categoryNode;
  final List<List<Category>> selectedCategoryLayers;

  int get currentLayer => selectedCategoryLayers.length -1;
  int get totalCategoryLayerLength => categoriesByLayer.length;
  String get categoryNodeString => CategoryUtil().categoryNodeToString(categoryNode);

  DiscoverState(this.categoriesByLayer,this.categoryNode,  this.selectedCategoryLayers, );
}

class InitialDiscoverState extends DiscoverState {
  InitialDiscoverState() : super([],[Category(id: "0",name:  AppText.discoverPageCategories,superId:  "",layer:  0),],[]);
}

class CategorySuccessState extends DiscoverState {
  CategorySuccessState(super.categoriesByLayer, super.categoryNode, super.selectedCategoryLayers);
}

class CategoryLoadingState extends DiscoverState{
  CategoryLoadingState(super.categoriesByLayer, super.categoryNode, super.selectedCategoryLayers, );

}
class CategoryFailState extends DiscoverState{
  final Fail fail;

  CategoryFailState(this.fail,super.categoriesByLayer, super.categoryNode, super.selectedCategoryLayers);

}
