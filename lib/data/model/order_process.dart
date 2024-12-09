import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';

import '../../sddklibrary/annotation/test_annotation.dart';

class OrderModel implements PurchaseModel {
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

  final ReturnModel? activeReturn;

  OrderModel._(
      {required this.id,
      required this.products,
      required this.address,
      required this.uid,
      required this.statusPaid,
      required this.statusOrderTaken,
      required this.statusShipped,
      required this.activeReturn,
      required this.statusDelivered});

  @TestOnly()
  OrderModel.testOnly(
      {required this.id,
      required this.products,
      required this.address,
      required this.uid,
      required this.statusPaid,
      required this.statusOrderTaken,
      required this.statusShipped,
      required this.activeReturn,
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
      return OrderModel._(
          id: id,
          products: products,
          address: address,
          activeReturn: activeReturn,
          uid: uid,
          statusPaid: statusPaid,
          statusOrderTaken: processing.cancelByCustomer(message),
          statusShipped: statusShipped,
          statusDelivered: statusDelivered);
    }
    if (processing is OrderShipped) {
      return OrderModel._(
          id: id,
          products: products,
          uid: uid,
          address: address,
          activeReturn: activeReturn,
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
  OrderPaid.create()
      : super(
            purchaseStatusType: OrderStatusType.paid,
            status: PurchaseStatus.success,
            cancelableWhileProcessing: false,
            dateTime: DateTime.now());

  @override
  OrderTaken nextStatus(OrderModel orderModel) => orderModel.statusOrderTaken;
}

class OrderTaken extends PurchaseProcess {
  @TestOnly()
  OrderTaken.testOnly(
      {required super.status,
      required super.dateTime,
      super.message,
      super.receipt})
      : super(
            purchaseStatusType: OrderStatusType.orderTaken,
            cancelableWhileProcessing: true);

  OrderTaken._(
      {required super.status,
      required super.dateTime,
      super.message,
      super.receipt})
      : super(
            purchaseStatusType: OrderStatusType.orderTaken,
            cancelableWhileProcessing: true);

  OrderTaken.waiting()
      : this._(
          dateTime: null,
          status: PurchaseStatus.waiting,
          receipt: null,
        );

  OrderTaken cancelByCustomer(String message) {
    return OrderTaken._(
        status: PurchaseStatus.canceled,
        dateTime: DateTime.now(),
        message: "${AppText.orderPageCanceledByCustomer}: $message",
        receipt: receipt);
  }

  @override
  OrderShipped nextStatus(OrderModel orderModel) => orderModel.statusShipped;
}

class OrderShipped extends PurchaseProcess {
  @TestOnly()
  OrderShipped.testOnly(
      {required super.dateTime,
      super.message,
      required super.status,
      required super.cargoNo})
      : super(
            purchaseStatusType: OrderStatusType.shipped,
            cancelableWhileProcessing: true);

  OrderShipped._(
      {required super.dateTime,
      super.message,
      required super.status,
      required super.cargoNo})
      : super(
            purchaseStatusType: OrderStatusType.shipped,
            cancelableWhileProcessing: true);

  OrderShipped.waiting()
      : this._(
          dateTime: null,
          status: PurchaseStatus.waiting,
          cargoNo: null,
        );

  OrderShipped canceledByCustomer(String message) {
    return OrderShipped._(
      status: PurchaseStatus.canceled,
      dateTime: DateTime.now(),
      message: "${AppText.orderPageCanceledByCustomer}: $message",
      cargoNo: cargoNo,
    );
  }

  @override
  OrderDelivered nextStatus(OrderModel orderModel) =>
      orderModel.statusDelivered;
}

class OrderDelivered extends PurchaseProcess {
  @TestOnly()
  OrderDelivered.testOnly(
      {required super.dateTime, super.message, required super.status})
      : super(
            purchaseStatusType: OrderStatusType.delivered,
            cancelableWhileProcessing: false);

  OrderDelivered._(
      {required super.dateTime, super.message, required super.status})
      : super(
            purchaseStatusType: OrderStatusType.delivered,
            cancelableWhileProcessing: false);

  OrderDelivered.waiting()
      : this._(
          dateTime: null,
          status: PurchaseStatus.waiting,
        );

  bool? get hasTheRightOfWithdrawalExpired {
    if (dateTime == null) return null;

    final difference = DateTime.now().difference(dateTime!).inDays.abs();

    return difference > FakeAppDefaults.defaultReturnDay;
  }
}

enum OrderStatusType implements PurchaseStatusType {
  paid('paid', AppText.orderPagePayingSuccess),
  orderTaken('order_taken', AppText.orderPageOrderTaken),
  shipped('shipped', AppText.orderPageShipped),
  delivered('delivered', AppText.orderPageDelivered),
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
