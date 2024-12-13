import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';

import '../../../data/model/product_feature.dart';

class SearchEvent {}

class ClearStateEvent extends SearchEvent {}

class SearchTextAndGetProductsEvent extends SearchTextEvent {

  SearchTextAndGetProductsEvent(super.text);
}

class SearchTextEvent extends SearchEvent {
  final String text;

  SearchTextEvent(this.text);
}

class FocusSearchTextEvent extends SearchEvent {
  final bool isFocused;

  FocusSearchTextEvent(this.isFocused);
}

class AddRecentSearchEvent extends SearchEvent {
  final String recentSearch;
  final String uid;

  AddRecentSearchEvent(this.recentSearch, this.uid);
}

///Filters

class LoadCachedFiltersEvent extends SearchEvent {}
class FilterSelectorEvent extends SearchEvent {
  final List<ProductFeatureOption>? featureOptions;
  final List<Category>? categories;

  FilterSelectorEvent({this.featureOptions, this.categories});
}

class AddFilterToCacheEvent extends FilterSelectorEvent {
  AddFilterToCacheEvent({super.featureOptions, super.categories});
}

class ClearCachedFiltersOfFeatureOptionEvent extends SearchEvent {
  final ProductFeature productFeature;

  ClearCachedFiltersOfFeatureOptionEvent(this.productFeature);
}

class ClearCachedFiltersEvent extends SearchEvent {}

class ApplyFiltersAndGetProductsEvent extends SearchEvent {}

class SelectFilterAndGetProductsDirectlyEvent extends FilterSelectorEvent {
  SelectFilterAndGetProductsDirectlyEvent({super.featureOptions, super.categories});
}

///Service Requests
class GetProductsEvent extends SearchEvent {}

class GetRecentSearchesEvent extends SearchEvent {
  final String uid;

  GetRecentSearchesEvent(this.uid);
}

class ClearAllRecentSearchEvent extends SearchEvent {}

class ClearSelectedRecentSearchEvent extends SearchEvent {
  final RecentSearch recentSearch;

  ClearSelectedRecentSearchEvent(this.recentSearch);
}
