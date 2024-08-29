import 'package:ecommerce_app_mobile/data/model/categories.dart';
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
  final Categories categoriesByLayer;
  final bool isSearchFocused;

  SearchState(
      {required this.searchText,
        required this.categoriesByLayer,
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
    Categories? categories,
    bool? isSearchFocused,
    List<Product>? products,
  }) {
    return SearchState(
        searchText: searchText ?? this.searchText,
        isSearchFocused: isSearchFocused ?? this.isSearchFocused,
        categoriesByLayer: categories ?? this.categoriesByLayer,
        recentSearches: recentSearches ?? this.recentSearches,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions,
        selectedCategories: selectedCategories ?? this.selectedCategories);
  }
}

class InitSearchState extends SearchState {
  InitSearchState()
      : super(categoriesByLayer: Categories.empty(),isSearchFocused: true,searchText: "",  recentSearches: [], selectedCategories: [], products: [], selectedFeatureOptions: []);
}

class ProductLoadingState extends SearchState {
  ProductLoadingState(
      {required super.searchText,
      required super.selectedCategories,
        required super.categoriesByLayer,
       required super.isSearchFocused,
      required super.recentSearches,
      required super.products,
      required super.selectedFeatureOptions});


  @override
  ProductLoadingState copyWith(
      {String? searchText,
        Categories? categories,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
        bool? isSearchFocused,
      bool? isFilterContainerActive,
      List<RecentSearch>? recentSearches,
      List<Product>? products}) {
    return ProductLoadingState(
        searchText: searchText ?? this.searchText,
        categoriesByLayer:  categories ?? this.categoriesByLayer,
        recentSearches: recentSearches ?? this.recentSearches,
        isSearchFocused: isSearchFocused ?? this.isSearchFocused,
        selectedCategories: selectedCategories ?? this.selectedCategories,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions);
  }
}

class ProductSuccessState extends SearchState {
  ProductSuccessState(
      {required super.searchText,
        required super.categoriesByLayer,
      required super.recentSearches,
      required super.selectedCategories,
      required super.products,
        required super.isSearchFocused,
        required super.selectedFeatureOptions});

  @override
  ProductSuccessState copyWith(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
        Categories? categories,
      List<Category>? selectedCategories,
        bool? isSearchFocused,
      bool? isFilterContainerActive,
      List<RecentSearch>? recentSearches,
      List<Product>? products}) {
    return ProductSuccessState(
        searchText: searchText ?? this.searchText,
        categoriesByLayer: categories??this.categoriesByLayer,
        recentSearches: recentSearches ?? this.recentSearches,
        isSearchFocused: isSearchFocused ?? this.isSearchFocused,
        selectedCategories: selectedCategories ?? this.selectedCategories,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions);
  }
}

class ProductFailState extends SearchState {
  final Fail fail;

  ProductFailState(
      {required super.searchText,
        required super.categoriesByLayer,
        required super.isSearchFocused,
        required super.recentSearches,
      required super.products,
      required super.selectedCategories,
      required super.selectedFeatureOptions,
      required this.fail});

  @override
  ProductFailState copyWith(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
        Categories? categories,
        bool? isSearchFocused,
      List<Category>? selectedCategories,
      bool? isFilterContainerActive,
      List<RecentSearch>? recentSearches,
      List<Product>? products}) {
    return ProductFailState(
        searchText: searchText ?? this.searchText,
        recentSearches: recentSearches ?? this.recentSearches,
        categoriesByLayer: categories ?? this.categoriesByLayer,
        selectedCategories: selectedCategories ?? this.selectedCategories,
        isSearchFocused: isSearchFocused ?? this.isSearchFocused,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions,
        fail: fail);
  }
}

class GetCategoriesFailState extends SearchState{
  final Fail fail;
  GetCategoriesFailState(this.fail, {required super.searchText, required super.categoriesByLayer, required super.isSearchFocused, required super.selectedCategories,  required super.recentSearches, required super.products, required super.selectedFeatureOptions});
  
}
class GetCategoriesSuccessState extends SearchState{
  GetCategoriesSuccessState({required super.searchText, required super.categoriesByLayer, required super.isSearchFocused, required super.selectedCategories, required super.recentSearches, required super.products, required super.selectedFeatureOptions});
  
}
class GetCategoriesLoadingState extends SearchState{
  GetCategoriesLoadingState({required super.searchText, required super.categoriesByLayer, required super.isSearchFocused, required super.selectedCategories,  required super.recentSearches, required super.products, required super.selectedFeatureOptions});
  
}

