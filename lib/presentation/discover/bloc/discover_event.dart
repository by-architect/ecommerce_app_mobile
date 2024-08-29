import 'package:ecommerce_app_mobile/data/model/categories.dart';

import '../../../data/model/category.dart';

class DiscoverEvent {}


class GetCategoriesDiscoverEvent extends DiscoverEvent{
final Categories categories;

GetCategoriesDiscoverEvent(this.categories);
}

class NextCategoryLayerEvent extends DiscoverEvent{
  final Category selectedCategory;

  NextCategoryLayerEvent(this.selectedCategory);
}
class PreviousCategoryLayerEvent extends DiscoverEvent{

  PreviousCategoryLayerEvent();
}
