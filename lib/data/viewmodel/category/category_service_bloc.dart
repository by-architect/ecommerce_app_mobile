import 'package:ecommerce_app_mobile/data/fakerepository/fake_product_service.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sddklibrary/helper/Log.dart';

class CategoryServiceBloc extends Bloc<CategoryServiceEvent, CategoryServiceState> {
  CategoryServiceBloc() : super(GetCategoriesByLayerInitState()) {
    final ProductServiceProvider service = ProductServiceProvider();

    on<GetCategoriesEvent>((event, emit) async {
      emit(GetCategoriesByLayerLoadingState());
      final resource = await service.getCategoriesByLayer();
      switch (resource.status) {
        case Status.success:
          emit(GetCategoriesByLayerSuccessState(resource.data!));
          break;
        case Status.fail:
          emit(GetCategoriesByLayerFailState(resource.error!));
          break;
        case Status.loading:
          emit(GetCategoriesByLayerLoadingState());
          break;
        case Status.stable:
          emit(GetCategoriesByLayerInitState());
      }
    });

  }
}
