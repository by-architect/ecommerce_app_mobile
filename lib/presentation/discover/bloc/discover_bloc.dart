import 'package:ecommerce_app_mobile/common/util/category_util.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_event.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sddklibrary/helper/resource.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(InitialDiscoverState()) {
    ProductServiceProvider service = ProductServiceProvider();

    on<LoadCategoriesEvent>((event, emit) async {
      emit(InitialDiscoverState());
      emit(CategoryLoadingState(state.categoriesByLayer, state.categoryNode, state.selectedCategoryLayers));
      final resource = await service.getCategoriesByLayer();
      switch (resource.status) {
        case Status.success:
          emit(CategorySuccessState(resource.data!, state.categoryNode, [resource.data!.first]));
          break;
        case Status.fail:
          emit(CategoryFailState(resource.error!, state.categoriesByLayer, state.categoryNode, state.selectedCategoryLayers));
          break;
        case Status.loading:
          emit(CategoryLoadingState(state.categoriesByLayer, state.categoryNode, state.selectedCategoryLayers));
          break;
        case Status.stable:
          emit(CategoryLoadingState(state.categoriesByLayer, state.categoryNode, state.selectedCategoryLayers));
      }
    });
    on<NextCategoryLayerEvent>((event, emit) {
      emit(CategoryLoadingState(state.categoriesByLayer, state.categoryNode, state.selectedCategoryLayers));
      final List<Category> nodeList = state.categoryNode;
      nodeList.add(event.selectedCategory);
      final List<List<Category>> selectedCategoryLayers = state.selectedCategoryLayers;
      final nextLayer = CategoryUtil().getNextCategoryLayer(state.categoriesByLayer[state.currentLayer + 1], event.selectedCategory);
      selectedCategoryLayers.add(nextLayer);
      emit(CategorySuccessState(state.categoriesByLayer, nodeList, selectedCategoryLayers));
    });

    on<PreviousCategoryLayerEvent>((event, emit) {
      emit(CategoryLoadingState(state.categoriesByLayer, state.categoryNode, state.selectedCategoryLayers));
      List<Category> nodeList = state.categoryNode;
      nodeList.removeLast();
      final List<List<Category>> selectedCategoryLayers = state.selectedCategoryLayers;
      selectedCategoryLayers.removeLast();
      emit(CategorySuccessState(state.categoriesByLayer, nodeList, selectedCategoryLayers));
    });
  }
}
