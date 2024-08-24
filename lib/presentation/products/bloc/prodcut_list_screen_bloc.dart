import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_list_screen_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_list_screen_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {
  ProductScreenBloc() : super(InitialProductScreenState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<AddCategoryEvent>(
      (event, emit) {
        emit(state.copyWith(categories: event.categories));
      },
    );
    on<AddProductFeatureOptionEvent>(
      (event, emit) {
        emit(state.copyWith(productFeatureOptions: event.productFeatureOptions));
      },
    );
    on<AddTagEvent>(
      (event, emit) {
        emit(state.copyWith(tags: event.tags));
      },
    );
    on<ClearStateEvent>(
          (event, emit) {
        emit(InitialProductScreenState());
      },
    );
    on<GetDiscountedProducts>(
          (event, emit) async {
        emit(ProductsLoadingState(
            categories: state.categories,
            productFeatureOptions: state.productFeatureOptions,
            tags: state.tags,
            products: state.products));
        final resource = await service.getProductByDiscount(30);
        switch (resource.status) {
          case Status.success:
            emit(ProductsSuccessState(
                categories: state.categories,
                productFeatureOptions: state.productFeatureOptions,
                tags: state.tags,
                products: resource.data!));
            break;
          case Status.fail:
            emit(ProductsFailState(
                fail: resource.error!,
                categories: state.categories,
                productFeatureOptions: state.productFeatureOptions,
                tags: state.tags,
                products: state.products));
            break;
          case Status.loading:
            emit(ProductsLoadingState(
                categories: state.categories,
                productFeatureOptions: state.productFeatureOptions,
                tags: state.tags,
                products: state.products));
            break;
          case Status.stable:
            break;
        }
      },
    );
    on<GetProductsEvent>(
      (event, emit) async {
        emit(ProductsLoadingState(
            categories: state.categories,
            productFeatureOptions: state.productFeatureOptions,
            tags: state.tags,
            products: state.products));
        final resource = await service.getProductsBySearchEvent(
            selectedTags: state.tags, selectedCategories: state.categories, selectedFeatureOptions: state.productFeatureOptions);
        switch (resource.status) {
          case Status.success:
            emit(ProductsSuccessState(
                categories: state.categories,
                productFeatureOptions: state.productFeatureOptions,
                tags: state.tags,
                products: resource.data!));
            break;
          case Status.fail:
            emit(ProductsFailState(
                fail: resource.error!,
                categories: state.categories,
                productFeatureOptions: state.productFeatureOptions,
                tags: state.tags,
                products: state.products));
            break;
          case Status.loading:
            emit(ProductsLoadingState(
                categories: state.categories,
                productFeatureOptions: state.productFeatureOptions,
                tags: state.tags,
                products: state.products));
            break;
          case Status.stable:
            break;
        }
      },
    );
  }
}
