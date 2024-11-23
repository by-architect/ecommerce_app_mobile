import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process_interface.dart';

class OrderModel implements Purchase {
  @override
  final String id;
  @override
  final String uid;
  @override
  final List<ProductWithQuantity> products;
  @override
  final Address address;

  final OrderPaid statusPaid;
  final OrderTaken statusOrderTaken;
  final OrderShipped statusShipped;
  final OrderDelivered statusDelivered;

  OrderModel(
      {required this.id,
      required this.products,
      required this.address,
      required this.uid,
      required this.statusPaid,
      required this.statusOrderTaken,
      required this.statusShipped,
      required this.statusDelivered});

  static OrderModel fromMap(
    Map<String, dynamic> map,
  ) {
    //todo: implement
    throw UnimplementedError();
  }

  PurchaseProcess? get getProcessing =>
      statusOrderTaken.status == PurchaseStatus.success
          ? statusShipped.status == PurchaseStatus.success
              ? statusDelivered.status == PurchaseStatus.success
                  ? null
                  : statusDelivered
              : statusShipped
          : statusOrderTaken;

  OrderModel? cancelOrder(String message) {
    final processing = getProcessing;
    if (processing == null) return null;
    if (processing is OrderTaken) {
      return OrderModel(
          id: id,
          products: products,
          address: address,
          uid: uid,
          statusPaid: statusPaid,
          statusOrderTaken: processing.cancelByCustomer(message),
          statusShipped: statusShipped,
          statusDelivered: statusDelivered);
    }
    if (processing is OrderShipped) {
      return OrderModel(
          id: id,
          products: products,
          uid: uid,
          address: address,
          statusPaid: statusPaid,
          statusOrderTaken: statusOrderTaken,
          statusShipped: processing.canceledByCustomer(message),
          statusDelivered: statusDelivered);
    }
    return null;
  }

  @override
  PurchaseProcessHandler get purchaseProcessesHandler => PurchaseProcessHandler(
      one: statusPaid,
      two: statusOrderTaken,
      three: statusShipped,
      four: statusDelivered);
}

class OrderPaid extends PurchaseProcess {
  OrderPaid({required super.dateTime})
      : super(
            purchaseStatusType: OrderStatusType.paid,
            status: PurchaseStatus.success,
            cancelableWhileProcessing: false);

  @override
  OrderTaken nextStatus(OrderModel orderModel) => orderModel.statusOrderTaken;
}

class OrderTaken extends PurchaseProcess {
  OrderTaken(
      {required super.status,
      required super.dateTime,
      super.message,
      super.receipt})
      : super(
            purchaseStatusType: OrderStatusType.orderTaken,
            cancelableWhileProcessing: true);

  OrderTaken cancelByCustomer(String message) {
    return OrderTaken(
        status: PurchaseStatus.canceled,
        dateTime: DateTime.now(),
        message: "${AppText.orderPageCanceledByCustomer}: $message",
        receipt: receipt);
  }

  @override
  OrderShipped nextStatus(OrderModel orderModel) => orderModel.statusShipped;
}

class OrderShipped extends PurchaseProcess {
  OrderShipped({required super.dateTime, super.message, required super.status})
      : super(
            purchaseStatusType: OrderStatusType.shipped,
            cancelableWhileProcessing: true);

  OrderShipped canceledByCustomer(String message) {
    return OrderShipped(
      status: PurchaseStatus.canceled,
      dateTime: DateTime.now(),
      message: "${AppText.orderPageCanceledByCustomer}: $message",
    );
  }

  @override
  OrderDelivered nextStatus(OrderModel orderModel) =>
      orderModel.statusDelivered;
}

class OrderDelivered extends PurchaseProcess {
  OrderDelivered(
      {required super.dateTime, super.message, required super.status})
      : super(
            purchaseStatusType: OrderStatusType.delivered,
            cancelableWhileProcessing: false);
}

enum OrderStatusType implements PurchaseStatusType {
  paid(ApiDeliveryProcesses.payingSuccess, AppText.orderPagePayingSuccess),
  orderTaken(ApiDeliveryProcesses.orderTaken, AppText.orderPageOrderTaken),
  shipped(ApiDeliveryProcesses.shipped, AppText.orderPageShipped),
  delivered(ApiDeliveryProcesses.delivered, AppText.orderPageDelivered),
  ;

  OrderStatusType fromServerMessages(String message) {
    return OrderStatusType.values
        .firstWhere((element) => element.apiData == message);
  }

  @override
  final String apiData;
  @override
  final AppText userText;

  const OrderStatusType(this.apiData, this.userText);
}
