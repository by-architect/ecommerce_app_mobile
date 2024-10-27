import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';

import '../../../data/model/product.dart';
import '../../../data/model/product_feature.dart';
import '../../../sddklibrary/util/fail.dart';

class SearchState {
  final String searchText;
  final List<ProductFeatureOption> selectedFeatureOptions;
  final List<Category> selectedCategories;
  final List<RecentSearch> recentSearches;
  final List<Product> products;
  final bool isSearchFocused;

  bool get canPopState => products.isEmpty ? true : !isSearchFocused;

  SearchState(
      {required this.searchText,
      required this.isSearchFocused,
      required this.selectedCategories,
      required this.recentSearches,
      required this.products,
      required this.selectedFeatureOptions});

  List<RecentSearch> get getSearchReversed => recentSearches.reversed.toList();

  SearchState copyWith({
    String? searchText,
    List<ProductFeatureOption>? selectedFeatureOptions,
    List<Category>? selectedCategories,
    List<RecentSearch>? recentSearches,
    bool? isSearchFocused,
    List<Product>? products,
  }) {
    return SearchState(
        searchText: searchText ?? this.searchText,
        isSearchFocused: isSearchFocused ?? this.isSearchFocused,
        recentSearches: recentSearches ?? this.recentSearches,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions,
        selectedCategories: selectedCategories ?? this.selectedCategories);
  }
}

class InitSearchState extends SearchState {
  InitSearchState()
      : super(
            isSearchFocused: true,
            searchText: "",
            recentSearches: [],
            selectedCategories: [],
            products: [],
            selectedFeatureOptions: []);
}

class ProductLoadingState extends SearchState {
  final SearchState state;

  ProductLoadingState({required this.state})
      : super(
            searchText: state.searchText,
            recentSearches: state.recentSearches,
            selectedCategories: state.selectedCategories,
            products: state.products,
            isSearchFocused: state.isSearchFocused,
            selectedFeatureOptions: state.selectedFeatureOptions);

}

class ProductSuccessState extends SearchState {

  final SearchState state;

  ProductSuccessState({required this.state})
      : super(
            searchText: state.searchText,
            recentSearches: state.recentSearches,
            selectedCategories: state.selectedCategories,
            products: state.products,
            isSearchFocused: state.isSearchFocused,
            selectedFeatureOptions: state.selectedFeatureOptions);

}

class ProductFailState extends SearchState {
  final Fail fail;
  final SearchState state;

  ProductFailState({required this.state, required this.fail})
      : super(
            searchText: state.searchText,
            recentSearches: state.recentSearches,
            selectedCategories: state.selectedCategories,
            products: state.products,
            isSearchFocused: state.isSearchFocused,
            selectedFeatureOptions: state.selectedFeatureOptions);

}

