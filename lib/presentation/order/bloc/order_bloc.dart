import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/order_event.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/orders_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Bloc<OrderEvent, OrdersState> {
  OrdersBloc() : super(OrderInitialState()) {
    final service = ProductServiceProvider();
    on<GetOrdersEvent>((event, emit) async {
      emit(OrdersLoadingState(orders: state.orders));
      final resource = await service.getOrderList(event.uid);
      if (resource.isSuccess) {
        emit(OrdersSuccessState(orders: resource.data!));
      } else {
        emit(OrdersFailState(fail: resource.error!, orders: state.orders));
      }
    });

    on<CancelOrderEvent>((event, emit) async {
      final canceledOrder = event.canceledOrder.cancelOrder(event.message);
      if (canceledOrder == null) return;
      emit(OrderCancelLoadingState(orders: state.orders));
      final resource = await service.cancelOrder(canceledOrder);
      if (resource.isSuccess) {
        emit(OrderCancelSuccessState(orders: state.orders));
      } else {
        emit(OrderCancelFailState(fail: resource.error!, orders: state.orders));
      }
    });

  }
}
