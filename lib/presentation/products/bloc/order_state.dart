import 'package:ecommerce_app_mobile/data/model/purchase_process_interface.dart';

import '../../../common/constant/api_constants.dart';
import '../../../data/model/product.dart';
import '../../../data/model/order.dart';

class OrderState {
  final PurchaseProcess statusPaid;
  final PurchaseProcess statusOrderTaken;
  final PurchaseProcess statusShipped;
  final PurchaseProcess statusDelivered;

  OrderState()
      : statusPaid = OrderPaid(dateTime: DateTime.now()),
        statusOrderTaken = OrderTaken(
            dateTime: DateTime.now(), status: PurchaseStatus.waiting),
        statusShipped = OrderShipped(
            dateTime: DateTime.now(), status: PurchaseStatus.waiting),
        statusDelivered = OrderDelivered(
            dateTime: DateTime.now(), status: PurchaseStatus.waiting);

  Map<String, dynamic> toMap() {
    return {
      //todo: implement
    };
  }
}
