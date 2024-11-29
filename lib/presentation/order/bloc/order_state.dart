import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

class OrderState {
  final List<OrderModel> orders;

  OrderState({required this.orders});
}

class OrderInitialState extends OrderState {
  OrderInitialState() : super(orders: []);
}

class OrdersLoadingState extends OrderState {
  OrdersLoadingState({required super.orders});
}

class OrdersSuccessState extends OrderState {
  OrdersSuccessState({required super.orders});
}

class OrdersFailState extends OrderState {
  final Fail fail;

  OrdersFailState({required this.fail, required super.orders});
}

class OrderCancelSuccessState extends OrderState {
  OrderCancelSuccessState({required super.orders});
}

class OrderCancelLoadingState extends OrderState {
  OrderCancelLoadingState({required super.orders});
}

class OrderCancelFailState extends OrderState {
  final Fail fail;

  OrderCancelFailState({required this.fail, required super.orders});
}
