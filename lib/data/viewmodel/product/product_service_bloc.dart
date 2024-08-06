import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/product/product_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/product/product_service_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductServiceBloc extends Bloc<ProductServiceEvent, ProductServiceState> {
  ProductServiceBloc() : super(GetAllProductsInitialState()) {
    final ProductServiceProvider productService = ProductServiceProvider();

    on<GetProductsByCategoryEvent>((event, emit) async {
      emit(GetProductsByCategoryLoadingState());
      final resource = await productService.getProductsByCategory(event.categoryId);
      switch (resource.status) {
        case Status.success:
          emit(GetProductsByCategorySuccessState(resource.data!));
        case Status.fail:
          emit(GetProductsByCategoryFailState(resource.error!));
        case Status.loading:
          emit(GetProductsByCategoryLoadingState());
        case Status.stable:
          emit(GetProductsByCategoryLoadingState());
      }
    });
  }
}
