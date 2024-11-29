import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnDetailsBloc extends Bloc<ReturnDetailsEvent, ReturnDetailsState> {
  ReturnDetailsBloc() : super(InitialReturnState()) {
    final service = ProductServiceProvider();
    on<RequestReturnEvent>((event, emit) async {
      emit(ReturnRequestLoadingState(state));
      final resource = await service.addReturnProcess(state, state.userId);
      if (resource.isSuccess) {
        emit(ReturnRequestSuccessState(state));
      } else {
        emit(ReturnRequestFailState(state, resource.error!));
      }
    });
    on<ReturnTypeEvent>((event, emit) {
      emit(state.copyWith(returnType: event.returnType));
    });

    on<ReturnReasonEvent>((event, emit) {
      emit(state.copyWith(returnReason: event.returnReason));
    });

    on<SelectedProductEvent>((event, emit) {
      final newProduct = state.products;
      newProduct[event.index] = event.product;
      emit(state.copyWith(products: newProduct));
    });

    on<InitialProductsEvent>((event, emit) {
      emit(state.copyWith(products: event.products));
    });

  }
}
