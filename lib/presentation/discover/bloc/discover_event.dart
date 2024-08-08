import '../../../data/model/category.dart';

class DiscoverEvent {}

class CategoryEvent extends DiscoverEvent{}

class LoadCategoriesEvent extends DiscoverEvent{

}

class NextCategoryLayerEvent extends CategoryEvent{
  final Category selectedCategory;

  NextCategoryLayerEvent(this.selectedCategory);
}
class PreviousCategoryLayerEvent extends CategoryEvent{

  PreviousCategoryLayerEvent();
}
