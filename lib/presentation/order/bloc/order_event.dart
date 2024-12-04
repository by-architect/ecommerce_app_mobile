import 'package:ecommerce_app_mobile/data/model/order_process.dart';

import '../../../data/model/return_process.dart';

class OrderEvent {

}
class GetOrdersEvent extends OrderEvent{
  final String uid;

  GetOrdersEvent(this.uid);
}

class CancelOrderEvent extends OrderEvent{
  final OrderModel canceledOrder;
  final String message;

  CancelOrderEvent({required this.canceledOrder, required this.message});
}

class CancelReturnEvent extends OrderEvent{
  final ReturnModel canceledReturn;
  final String message;

  CancelReturnEvent({required this.canceledReturn,required this.message });

}