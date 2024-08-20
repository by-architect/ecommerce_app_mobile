import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_event.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitHomeState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<GetProductsEvent>(
      (event, emit) async {
        emit(ProductsLoadingState(
            bestSellerProducts: state.bestSellerProducts,
            lastAddedProducts: state.lastAddedProducts,
            discountedProducts: state.discountedProducts));
        final resourceLastAdded = await service.getProductByLastAdded(10);
        final resourceBestSeller = await service.getProductByBestSeller(10);
        final resourceDiscount = await service.getProductByDiscount(10);

        if (resourceLastAdded.isSuccess && resourceDiscount.isSuccess && resourceBestSeller.isSuccess) {
          emit(ProductsSuccessState(
              bestSellerProducts: resourceBestSeller.data!,
              lastAddedProducts: resourceLastAdded.data!,
              discountedProducts: resourceDiscount.data!));
        } else {
          emit(ProductsFailState(
              fail: resourceBestSeller.error ??
                  resourceDiscount.error ??
                  resourceLastAdded.error ??
                  Fail(userMessage: AppText.errorFetchingData),
              bestSellerProducts: state.bestSellerProducts,
              lastAddedProducts: state.lastAddedProducts,
              discountedProducts: state.discountedProducts));
        }
      },
    );
  }
}
