import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitSearchState()) {
    ProductServiceProvider service = ProductServiceProvider();

    on<ClearStateEvent>(
      (event, emit) {
        emit(InitSearchState());
      },
    );

    on<SearchTextEvent>(
      (event, emit) {
        emit(state.copyWith(searchText: event.text));
      },
    );

    on<SelectedFeatureOptionsEvent>((event, emit) {
      emit(state.copyWith(selectedFeatureOptions: event.selectedFeatureOptions));
    });

    on<ToggleContainerEvent>(
      (event, emit) {
        emit(state.copyWith(isFilterContainerActive: !state.isFilterContainerActive));
      },
    );

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
        Log.test(title: "recent search",data: event.recentSearch.toString());
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
        event.productFeature.options.forEach(
          (featureOption) {
            selectedFeatureOptions.removeWhere((option) => option.id == featureOption.id);
          },
        );
        emit(state.copyWith(selectedFeatureOptions: selectedFeatureOptions));
      },
    );
    on<GetProductsEvent>(
      (event, emit) async {
        emit(ProductLoadingState(
            searchText: state.searchText,
            features: state.features,
            isFilterContainerActive: state.isFilterContainerActive,
            recentSearches: state.recentSearches,
            products: state.products,
            selectedFeatureOptions: state.selectedFeatureOptions));

        final response =
            await service.getProductsBySearchEvent(searchText: state.searchText, selectedFeatureOptions: state.selectedFeatureOptions);

        switch (response.status) {
          case Status.success:
            emit(ProductSuccessState(
                searchText: state.searchText,
                features: state.features,
                isFilterContainerActive: state.isFilterContainerActive,
                recentSearches: state.recentSearches,
                products: response.data!,
                selectedFeatureOptions: state.selectedFeatureOptions));
            break;
          case Status.fail:
            emit(ProductFailState(
                searchText: state.searchText,
                features: state.features,
                isFilterContainerActive: state.isFilterContainerActive,
                recentSearches: state.recentSearches,
                products: state.products,
                selectedFeatureOptions: state.selectedFeatureOptions,
                fail: response.error!));
            break;
          case Status.loading:
            emit(ProductLoadingState(
                searchText: state.searchText,
                features: state.features,
                isFilterContainerActive: state.isFilterContainerActive,
                recentSearches: state.recentSearches,
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
