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

  @override
  String toString() {
    return 'SearchState{searchText: $searchText, selectedFeatureOptions: $selectedFeatureOptions, selectedCategories: $selectedCategories, recentSearches: $recentSearches, products: $products, isSearchFocused: $isSearchFocused}';
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

  @override
  ProductLoadingState copyWith({
    String? searchText,
    List<ProductFeatureOption>? selectedFeatureOptions,
    List<Category>? selectedCategories,
    List<RecentSearch>? recentSearches,
    bool? isSearchFocused,
    List<Product>? products,
  }) {
    return ProductLoadingState(
        state: SearchState(
            searchText: searchText ?? state.searchText,
            isSearchFocused: isSearchFocused ?? state.isSearchFocused,
            recentSearches: recentSearches ?? state.recentSearches,
            products: products ?? state.products,
            selectedFeatureOptions: selectedFeatureOptions ?? state.selectedFeatureOptions,
            selectedCategories: selectedCategories ?? state.selectedCategories));
  }
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

  @override
  SearchState copyWith(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<RecentSearch>? recentSearches,
      bool? isSearchFocused,
      List<Product>? products}) {
    return ProductSuccessState(
        state: SearchState(
            searchText: searchText ?? state.searchText,
            isSearchFocused: isSearchFocused ?? state.isSearchFocused,
            recentSearches: recentSearches ?? state.recentSearches,
            products: products ?? state.products,
            selectedFeatureOptions: selectedFeatureOptions ?? state.selectedFeatureOptions,
            selectedCategories: selectedCategories ?? state.selectedCategories));
  }
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

  @override
  SearchState copyWith(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<RecentSearch>? recentSearches,
      bool? isSearchFocused,
      List<Product>? products}) {
    return ProductFailState(
        state: SearchState(
            searchText: searchText ?? state.searchText,
            isSearchFocused: isSearchFocused ?? state.isSearchFocused,
            recentSearches: recentSearches ?? state.recentSearches,
            products: products ?? state.products,
            selectedFeatureOptions: selectedFeatureOptions ?? state.selectedFeatureOptions,
            selectedCategories: selectedCategories ?? state.selectedCategories),
        fail: fail);
  }
}
