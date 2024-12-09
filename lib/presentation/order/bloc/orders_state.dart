import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

class OrdersState {
  final List<OrderModel> orders;

  OrdersState({required this.orders});
}

class OrderInitialState extends OrdersState {
  OrderInitialState() : super(orders: []);
}

class OrdersLoadingState extends OrdersState {
  OrdersLoadingState({required super.orders});
}

class OrdersSuccessState extends OrdersState {
  OrdersSuccessState({required super.orders});
}

class OrdersFailState extends OrdersState {
  final Fail fail;

  OrdersFailState({required this.fail, required super.orders});
}

class OrderCancelSuccessState extends OrdersState {
  OrderCancelSuccessState({required super.orders});
}

class OrderCancelLoadingState extends OrdersState {
  OrderCancelLoadingState({required super.orders});
}

class OrderCancelFailState extends OrdersState {
  final Fail fail;

  OrderCancelFailState({required this.fail, required super.orders});
}

