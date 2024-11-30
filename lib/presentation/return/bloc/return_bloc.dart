import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/returns_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/returns_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnsBloc extends Bloc<ReturnEvent, ReturnsState> {
  final service = ProductServiceProvider();

  ReturnsBloc() : super(ReturnsInitialState()) {
    on<GetReturns>((event, emit) async {
      emit(ReturnsLoadingState(state));
      final resource = await service.getReturnProcessList(event.uid);
      if (!resource.isSuccess) {
        emit(ReturnsFailedState(state, resource.error!));
      } else {
        emit(ReturnsSuccessState(state.copyWith(returns: resource.data!)));
      }
    });

/*
    on<RequestReturn>((event, emit) async {
      emit(RequestReturnLoadingState(state));
      final resource =
          await service.addReturnProcess(event.returnState, event.uid);
      if (!resource.isSuccess) {
        emit(RequestReturnFailedState(state, resource.error!));
      } else {
        emit(RequestReturnSuccessState(resource.data!));
      }
    });
*/

    on<CancelReturn>((event, emit) async {
      emit(CancelReturnLoadingState(state));
      final canceledReturn = event.returnModel.cancelReturn(event.message);
      if (canceledReturn == null) return;
      final resource = await service.updateReturnProcess(canceledReturn);
      if (!resource.isSuccess) {
        emit(CancelReturnFailedState(state, resource.error!));
      } else {
        emit(CancelReturnSuccessState(resource.data!));
      }
    });
  }
}
