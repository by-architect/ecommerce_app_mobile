class OrderEvent {

}
class GetOrdersEvent extends OrderEvent{
  final String uid;

  GetOrdersEvent(this.uid);
}

class CancelOrderEvent extends OrderEvent{
  final String orderId;

  CancelOrderEvent(this.orderId);
}