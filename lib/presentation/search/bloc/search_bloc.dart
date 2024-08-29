import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitSearchState()) {
    ProductServiceProvider service = ProductServiceProvider();

    on<ClearStateEvent>(
      (event, emit) {
        emit(state.copyWith(
            searchText: "",
            selectedCategories: [],
            recentSearches: state.recentSearches,
            isSearchFocused: true,
            products: [],
            selectedFeatureOptions: []));
      },
    );

    on<SearchTextEvent>(
      (event, emit) {
        emit(state.copyWith(
          searchText: event.text,
        ));
      },
    );

    on<FocusSearchTextEvent>(
      (event, emit) {
        emit(state.copyWith(isSearchFocused: event.isFocused));
      },
    );

    on<SelectedFeatureOptionsEvent>((event, emit) {
      emit(state.copyWith(selectedFeatureOptions: event.selectedFeatureOptions));
    });

    on<SelectedCategoriesEvent>((event, emit) {
      emit(state.copyWith(selectedCategories: event.categories));
    });

    on<ClearAllRecentSearchEvent>(
      (event, emit) {
        service.clearAllRecentSearch();
        emit(state.copyWith(recentSearches: []));
      },
    );
    on<ClearSelectedRecentSearchEvent>(
      (event, emit) {
        service.clearRecentSearch(event.recentSearch);
        List<RecentSearch> recentSearches = state.recentSearches;
        recentSearches.removeWhere(
          (recentSearch) => recentSearch.id == event.recentSearch.id,
        );
        emit(state.copyWith(recentSearches: recentSearches));
      },
    );

    on<AddRecentSearchEvent>(
      (event, emit) async {
        final resource = await service.addRecentSearch(event.recentSearch);

        resource.onSuccess((recentSearch) {
          List<RecentSearch> recentSearches = state.recentSearches;
          if (recentSearches.length > 5) {
            service.clearRecentSearch(recentSearches[0]);
            recentSearches.removeAt(0);
          }
          recentSearches.add(recentSearch);
          emit(state.copyWith(recentSearches: recentSearches));
        });
      },
    );

    on<ClearAllSelectedOptionsEvent>(
      (event, emit) {
        emit(state.copyWith(selectedFeatureOptions: []));
      },
    );

    on<ClearSelectedOptionsOfFeatureEvent>(
      (event, emit) {
        List<ProductFeatureOption> selectedFeatureOptions = state.selectedFeatureOptions;
        for (var featureOption in event.productFeature.options) {
            selectedFeatureOptions.removeWhere((option) => option.id == featureOption.id);
          }
        emit(state.copyWith(selectedFeatureOptions: selectedFeatureOptions));
      },
    );

    on<GetRecentSearchesEvent>(
      (event, emit) async {
        if (state.recentSearches.isEmpty) {
          final resource = await service.getRecentSearches();
          resource.onSuccess(
            (data) {
              emit(state.copyWith(recentSearches: data));
            },
          );
        }
      },
    );
/*
    on<GetCategoriesEvent>(
      (event, emit) async {
        if (state.categoriesByLayer.isEmpty) {
          final resource = await service.getCategoriesByLayer();
          resource.onSuccess(
            (data) {
              emit(state.copyWith(categories: data));
            },
          );
          resource.onFailure(
                (fail) {
              emit(ProductFailState(
                  searchText: state.searchText,
                  categoriesByLayer: state.categoriesByLayer,
                  isSearchFocused: state.isSearchFocused,
                  recentSearches: state.recentSearches,
                  products: state.products,
                  selectedCategories: state.selectedCategories,
                  selectedFeatureOptions: state.selectedFeatureOptions,
                  fail: fail));
            },
          );
        }
      },
    );
*/
/*
    on<GetProductFeaturesEvent>(
      (event, emit) async {
        if (state.features.isEmpty) {
          final resource = await service.getProductFeatures();
          resource.onSuccess(
            (data) {
              emit(state.copyWith(features: data));
            },
          );
          resource.onFailure(
            (fail) {
              emit(ProductFailState(
                  searchText: state.searchText,
                  features: state.features,
                  categoriesByLayer: state.categoriesByLayer,
                  isSearchFocused: state.isSearchFocused,
                  recentSearches: state.recentSearches,
                  products: state.products,
                  selectedCategories: state.selectedCategories,
                  selectedFeatureOptions: state.selectedFeatureOptions,
                  fail: fail));
            },
          );
        }
      },
    );
*/

    on<GetProductsEvent>(
      (event, emit) async {
        emit(ProductLoadingState(
            searchText: state.searchText,
            isSearchFocused: false,
            recentSearches: state.recentSearches,
            selectedCategories: state.selectedCategories,
            products: state.products,
            selectedFeatureOptions: state.selectedFeatureOptions));

        final response = await service.getProductsBySearchEvent(
            searchText: state.searchText,
            selectedFeatureOptions: state.selectedFeatureOptions,
            selectedCategories: state.selectedCategories);

        switch (response.status) {
          case Status.success:
            emit(ProductSuccessState(
                searchText: state.searchText,
                recentSearches: state.recentSearches,
                isSearchFocused: state.isSearchFocused,
                selectedCategories: state.selectedCategories,
                products: response.data!,
                selectedFeatureOptions: state.selectedFeatureOptions));
            break;
          case Status.fail:
            emit(ProductFailState(
                searchText: state.searchText,
                recentSearches: state.recentSearches,
                isSearchFocused: state.isSearchFocused,
                selectedCategories: state.selectedCategories,
                products: state.products,
                selectedFeatureOptions: state.selectedFeatureOptions,
                fail: response.error!));
            break;
          case Status.loading:
            emit(ProductLoadingState(
                searchText: state.searchText,
                isSearchFocused: state.isSearchFocused,
                recentSearches: state.recentSearches,
                selectedCategories: state.selectedCategories,
                products: state.products,
                selectedFeatureOptions: state.selectedFeatureOptions));
            break;
          case Status.stable:
            break;
        }
      },
    );
  }
}
