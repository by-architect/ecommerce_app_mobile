import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_event.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnBloc extends Bloc<ReturnEvent, ReturnState> {
  final service = ProductServiceProvider();

  ReturnBloc() : super(ReturnInitial()) {
    on<GetReturns>((event, emit) async {
      emit(ReturnsLoadingState(state));
      final resource = await service.getReturnProcessList(event.uid);
      try {
        emit(ReturnsSuccessState(state));
      } catch (e) {
        emit(ReturnsFailedState(state, resource.error!));
      }
    });

    on<RequestReturn>((event, emit) async {
      emit(RequestReturnLoadingState(state));
      final resource =
          await service.addReturnProcess(event.returnState, event.uid);
      try {
        emit(RequestReturnSuccessState(state));
      } catch (e) {
        emit(RequestReturnFailedState(state, resource.error!));
      }
    });

    on<CancelReturn>((event, emit) async {
      emit(CancelReturnLoadingState(state));
      final resource = await service.cancelReturn(event.returnId);
      try {
        emit(CancelReturnSuccessState(state));
      } catch (e) {
        emit(CancelReturnFailedState(state, resource.error!));
      }
    });
  }
}
