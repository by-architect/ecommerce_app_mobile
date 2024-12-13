import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ProductServiceProvider service = ProductServiceProvider();

  SearchBloc() : super(InitSearchState()) {
    on<ClearStateEvent>(_clearState);
    on<LoadCachedFiltersEvent>(_loadCachedFilters);
    on<SearchTextEvent>(_editText);
    on<SearchTextAndGetProductsEvent>(
      (event, emit) async {
        await _editText(event, emit);
        await _getProducts(event, emit);
      },
    );
    on<FocusSearchTextEvent>(_focusSearchText);
    on<AddFilterToCacheEvent>(_addFilterToCache);
    on<ClearCachedFiltersOfFeatureOptionEvent>(_clearCachedFiltersOfFeatureOption);
    on<ClearCachedFiltersEvent>(
      (event, emit) async {
        await _clearCachedCategories(event, emit);
        await _clearCachedProductFeatures(event, emit);
      },
    );
    on<ApplyFiltersAndGetProductsEvent>(
      (event, emit) async {
        await _applyCachedFilters(event, emit);
        await _getProducts(event, emit);
      },
    );
    on<SelectFilterAndGetProductsDirectlyEvent>(
      (event, emit) async {
        await _addFilterToCache(event, emit);
        await _applyCachedFilters(event, emit);
        await _getProducts(event, emit);
      },
    );
    on<ClearAllRecentSearchEvent>(_clearRecentSearches);
    on<ClearSelectedRecentSearchEvent>(_clearSelectedRecentSearch);
    on<AddRecentSearchEvent>(_addRecentSearch);
    on<GetRecentSearchesEvent>(_getRecentSearches);
    on<GetProductsEvent>(_getProducts);
  }

  _loadCachedFilters(LoadCachedFiltersEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        categoriesFilterCache: state.selectedCategories.toList(), productFeatureOptionsFilterCache: state.selectedFeatureOptions.toList()));
  }

  _clearState(ClearStateEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        searchText: "",
        selectedCategories: [],
        recentSearches: state.recentSearches,
        isSearchFocused: true,
        products: [],
        selectedFeatureOptions: []));
  }

  _editText(SearchTextEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchText: event.text));
  }

  _focusSearchText(FocusSearchTextEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(isSearchFocused: event.isFocused));
  }

  _addFilterToCache(FilterSelectorEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        categoriesFilterCache: event.categories ?? state.categoriesFilterCache,
        productFeatureOptionsFilterCache: event.featureOptions ?? event.featureOptions ?? state.productFeatureOptionsFilterCache));
  }

  _clearCachedFiltersOfFeatureOption(ClearCachedFiltersOfFeatureOptionEvent event, Emitter<SearchState> emit) {
    List<ProductFeatureOption> selectedFeatureOptions = state.selectedFeatureOptions.toList();
    for (var featureOption in event.productFeature.options) {
      selectedFeatureOptions.removeWhere((option) => option.id == featureOption.id);
    }
    emit(state.copyWith(productFeatureOptionsFilterCache: selectedFeatureOptions));
  }

  _clearCachedCategories(SearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(categoriesFilterCache: []));
  }

  _clearCachedProductFeatures(SearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(productFeatureOptionsFilterCache: []));
  }

  _applyCachedFilters(SearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        selectedCategories: state.categoriesFilterCache.toList(),
        selectedFeatureOptions: state.productFeatureOptionsFilterCache.toList(),
        categoriesFilterCache: [],
        productFeatureOptionsFilterCache: []));
  }

  _clearRecentSearches(ClearAllRecentSearchEvent event, Emitter<SearchState> emit) {
    service.clearAllRecentSearch(event.uid);
    emit(state.copyWith(recentSearches: []));
  }

  _clearSelectedRecentSearch(ClearSelectedRecentSearchEvent event, Emitter<SearchState> emit) {
    service.clearRecentSearch(event.recentSearch);
    List<RecentSearch> recentSearches = state.recentSearches;
    recentSearches.removeWhere(
      (recentSearch) => recentSearch.id == event.recentSearch.id,
    );
    emit(state.copyWith(recentSearches: recentSearches));
  }

  _addRecentSearch(AddRecentSearchEvent event, Emitter<SearchState> emit) async {
    final resource = await service.addRecentSearch(event.recentSearch, event.uid);

    resource.onSuccess((recentSearch) {
      List<RecentSearch> recentSearches = state.recentSearches;
      if (recentSearches.length > 5) {
        service.clearRecentSearch(recentSearches[0]);
        recentSearches.removeAt(0);
      }
      recentSearches.add(recentSearch);
      emit(state.copyWith(recentSearches: recentSearches));
    });
  }

  _getRecentSearches(GetRecentSearchesEvent event, Emitter<SearchState> emit) async {
    if (state.recentSearches.isEmpty) {
      final resource = await service.getRecentSearches(event.uid);
      resource.onSuccess(
        (data) {
          emit(state.copyWith(recentSearches: data));
        },
      );
    }
  }

  Future _getProducts(SearchEvent event, Emitter<SearchState> emit) async {
    emit(ProductLoadingState(state: state.copyWith(isSearchFocused: false)));

    final response = await service.getProductsBySearchEvent(
        searchText: state.searchText, selectedFeatureOptions: state.selectedFeatureOptions, selectedCategories: state.selectedCategories);

    switch (response.status) {
      case Status.success:
        emit(ProductSuccessState(
          state: state.copyWith(products: response.data!),
        ));
        break;
      case Status.fail:
        emit(ProductFailState(state: state.copyWith(), fail: response.error!));
        break;
      case Status.loading:
        emit(ProductLoadingState(state: state.copyWith(isSearchFocused: false)));
        break;
      case Status.stable:
        break;
    }
  }
}
