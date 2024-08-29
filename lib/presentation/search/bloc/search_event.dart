
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';

import '../../../data/model/product_feature.dart';

class SearchEvent{}
class ClearStateEvent extends SearchEvent{}

class SearchTextEvent extends SearchEvent{
  final String text ;
  SearchTextEvent(this.text);
}
class SelectedCategoriesEvent extends SearchEvent{
  final List<Category> categories;

  SelectedCategoriesEvent(this.categories);
}
class FocusSearchTextEvent extends SearchEvent{
  final bool isFocused;

  FocusSearchTextEvent(this.isFocused);
}

class SelectedFeatureOptionsEvent extends SearchEvent{
  final List<ProductFeatureOption> selectedFeatureOptions;

  SelectedFeatureOptionsEvent(this.selectedFeatureOptions);
}
class ClearSelectedOptionsOfFeatureEvent extends SearchEvent{
  final ProductFeature productFeature;

  ClearSelectedOptionsOfFeatureEvent(this.productFeature);
}
class ClearAllSelectedOptionsEvent extends SearchEvent{}
class AddRecentSearchEvent extends SearchEvent{
  final String recentSearch;

  AddRecentSearchEvent(this.recentSearch);
}


/*
class SearchTextGetProductsEvent extends SearchEvent{
  final String text ;
  SearchTextGetProductsEvent(this.text);
}
*/
class GetProductsEvent extends SearchEvent{}
class GetRecentSearchesEvent extends SearchEvent{}
class ClearAllRecentSearchEvent extends SearchEvent{}
class ClearSelectedRecentSearchEvent extends SearchEvent{
  final RecentSearch recentSearch;
  ClearSelectedRecentSearchEvent(this.recentSearch);
}
class GetCategoriesEvent extends SearchEvent{}
class GetCategories extends SearchEvent{}

