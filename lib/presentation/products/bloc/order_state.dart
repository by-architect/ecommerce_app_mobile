import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';

import '../../../common/constant/api_constants.dart';
import '../../../data/model/product.dart';
import '../../../data/model/order_process.dart';

class OrderState {
  final PurchaseProcess statusPaid;
  final PurchaseProcess statusOrderTaken;
  final PurchaseProcess statusShipped;
  final PurchaseProcess statusDelivered;
  final List<ProductWithQuantity> products;
  final Address address;
  final String userId;

  OrderState(
      {required this.address, required this.products, required this.userId})
      : statusPaid = OrderPaid.create(),
        statusOrderTaken = OrderTaken.waiting(),
        statusShipped = OrderShipped.waiting(),
        statusDelivered = OrderDelivered.waiting();

  Map<String, dynamic> toMap() {
    //todo: implement
    throw UnimplementedError();
  }
}
