import 'package:ecommerce_app_mobile/data/model/recent_search.dart';

import '../../../data/fakerepository/fake_models.dart';
import '../../../data/model/product.dart';
import '../../../data/model/product_feature.dart';
import '../../../sddklibrary/helper/fail.dart';

class SearchState {
  final String searchText;
  final List<ProductFeature> features;
  final List<ProductFeatureOption> selectedFeatureOptions;
  final bool isFilterContainerActive;
  final List<RecentSearch> recentSearches;
  final List<Product> products;

  SearchState(
      {required this.searchText,
      required this.features,
      required this.isFilterContainerActive,
      required this.recentSearches,
      required this.products,
      required this.selectedFeatureOptions});

  SearchState copyWith({
    String? searchText,
    List<ProductFeature>? features,
    List<ProductFeatureOption>? selectedFeatureOptions,
    bool? isFilterContainerActive,
    List<RecentSearch>? recentSearches,
    List<Product>? products,
  }) {
    return SearchState(
        searchText: searchText ?? this.searchText,
        features: features ?? this.features,
        isFilterContainerActive: isFilterContainerActive ?? this.isFilterContainerActive,
        recentSearches: recentSearches ?? this.recentSearches,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions);
  }
}

class InitSearchState extends SearchState {
  //todo: handle init state
  InitSearchState()
      : super(
            searchText: "text",
            features: FakeProductModels.productFeatures,
            isFilterContainerActive: false,
            recentSearches: FakeProductModels.recentSearches,
            products: [],
            selectedFeatureOptions: []);
}

class ProductLoadingState extends SearchState {
  ProductLoadingState(
      {required super.searchText,
      required super.features,
      required super.isFilterContainerActive,
      required super.recentSearches,
      required super.products,
      required super.selectedFeatureOptions});

  @override
  ProductLoadingState copyWith(
      {String? searchText,
      List<ProductFeature>? features,
      List<ProductFeatureOption>? selectedFeatureOptions,
      bool? isFilterContainerActive,
      List<RecentSearch>? recentSearches,
      List<Product>? products}) {
    return ProductLoadingState(
        searchText: searchText ?? this.searchText,
        features: features ?? this.features,
        isFilterContainerActive: isFilterContainerActive ?? this.isFilterContainerActive,
        recentSearches: recentSearches ?? this.recentSearches,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions);
  }
}

class ProductSuccessState extends SearchState {
  ProductSuccessState(
      {required super.searchText,
      required super.features,
      required super.isFilterContainerActive,
      required super.recentSearches,
      required super.products,
      required super.selectedFeatureOptions});

  @override
  ProductSuccessState copyWith(
      {String? searchText,
      List<ProductFeature>? features,
      List<ProductFeatureOption>? selectedFeatureOptions,
      bool? isFilterContainerActive,
      List<RecentSearch>? recentSearches,
      List<Product>? products}) {
    return ProductSuccessState(
        searchText: searchText ?? this.searchText,
        features: features ?? this.features,
        isFilterContainerActive: isFilterContainerActive ?? this.isFilterContainerActive,
        recentSearches: recentSearches ?? this.recentSearches,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions);
  }
}

class ProductFailState extends SearchState {
  final Fail fail;

  ProductFailState(
      {required super.searchText,
      required super.features,
      required super.isFilterContainerActive,
      required super.recentSearches,
      required super.products,
      required super.selectedFeatureOptions,
      required this.fail});

  @override
  ProductFailState copyWith(
      {String? searchText,
      List<ProductFeature>? features,
      List<ProductFeatureOption>? selectedFeatureOptions,
      bool? isFilterContainerActive,
      List<RecentSearch>? recentSearches,
      List<Product>? products}) {
    return ProductFailState(
        searchText: searchText ?? this.searchText,
        features: features ?? this.features,
        isFilterContainerActive: isFilterContainerActive ?? this.isFilterContainerActive,
        recentSearches: recentSearches ?? this.recentSearches,
        products: products ?? this.products,
        selectedFeatureOptions: selectedFeatureOptions ?? this.selectedFeatureOptions,
        fail: fail);
  }
}
