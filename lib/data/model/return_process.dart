import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';

class ReturnModel implements PurchaseModel {
  @override
  final String id;
  @override
  final String uid;
  final String orderId;
  @override
  final List<ProductWithQuantity> products;
  @override
  final Address address;

  final ReturnStatusReturnRequested statusReturnRequested;
  final ReturnStatusRequestAccepted statusRequestAccepted;
  final ReturnStatusShipped statusReturnShipped;
  final ReturnStatusDelivered statusReturnDelivered;
  final ReturnStatusReturnAccepted statusReturnAccepted;

  @TestOnly()
  ReturnModel.testOnly({
    required this.id,
    required this.orderId,
    required this.address,
    required this.statusReturnRequested,
    required this.statusRequestAccepted,
    required this.statusReturnShipped,
    required this.statusReturnDelivered,
    required this.statusReturnAccepted,
    required this.products,
    required this.uid,
  });

  ReturnModel._({
    required this.id,
    required this.orderId,
    required this.address,
    required this.statusReturnRequested,
    required this.statusRequestAccepted,
    required this.statusReturnShipped,
    required this.statusReturnDelivered,
    required this.statusReturnAccepted,
    required this.products,
    required this.uid,
  });

  @override
  PurchaseProcessHandler get purchaseProcessesHandler => PurchaseProcessHandler(
      one: statusReturnRequested,
      two: statusRequestAccepted,
      three: statusReturnShipped,
      four: statusReturnDelivered,
      five: statusReturnAccepted);

  PurchaseProcess? get getProcessing =>
      statusRequestAccepted.status == PurchaseStatus.success
          ? statusReturnShipped.status == PurchaseStatus.success
              ? statusReturnDelivered.status == PurchaseStatus.success
                  ? statusReturnAccepted.status == PurchaseStatus.success
                      ? null
                      : statusReturnAccepted
                  : statusReturnDelivered
              : statusReturnShipped
          : statusRequestAccepted;

  ReturnModel? cancelReturn(String message) {
    final processing = getProcessing;
    if (processing == null) return null;
    if (processing is ReturnStatusRequestAccepted) {
      return ReturnModel._(
          id: id,
          orderId: orderId,
          address: address,
          statusReturnRequested: statusReturnRequested,
          statusRequestAccepted: processing.canceledByCustomer(message),
          statusReturnShipped: statusReturnShipped,
          statusReturnDelivered: statusReturnDelivered,
          statusReturnAccepted: statusReturnAccepted,
          products: products,
          uid: uid);
    }
    if (processing is ReturnStatusShipped) {
      return ReturnModel._(
          id: id,
          orderId: orderId,
          address: address,
          statusReturnRequested: statusReturnRequested,
          statusRequestAccepted: statusRequestAccepted,
          statusReturnShipped: processing.canceledByCustomer(message),
          statusReturnDelivered: statusReturnDelivered,
          statusReturnAccepted: statusReturnAccepted,
          products: products,
          uid: uid);
    }
    return null;
  }
}

class ReturnStatusReturnRequested extends PurchaseProcess {
  final ReturnType returnType;
  final String returnReason;

  @TestOnly()
  ReturnStatusReturnRequested.testOnly({
    required super.message,
    required this.returnReason,
    required this.returnType,
    required super.dateTime,
  }) : super(
          cancelableWhileProcessing: false,
          status: PurchaseStatus.success,
          purchaseStatusType: ReturnStatusType.returnRequested,
        );

  ReturnStatusReturnRequested.create({
    required super.message,
    required this.returnType,
    required this.returnReason,
  }) : super(
            cancelableWhileProcessing: false,
            status: PurchaseStatus.success,
            purchaseStatusType: ReturnStatusType.returnRequested,
            dateTime: DateTime.now());
}

class ReturnStatusRequestAccepted extends PurchaseProcess {
  @TestOnly()
  ReturnStatusRequestAccepted.testOnly(
      {required super.message,
      required super.dateTime,
      required super.status,
      required super.cargoNo})
      : super(
          cancelableWhileProcessing: true,
          purchaseStatusType: ReturnStatusType.returnRequestAccepted,
        );

  ReturnStatusRequestAccepted._(
      {required super.message, required super.dateTime, required super.status})
      : super(
          cancelableWhileProcessing: true,
          purchaseStatusType: ReturnStatusType.returnRequestAccepted,
        );

  ReturnStatusRequestAccepted.waiting()
      : this._(
            status: PurchaseStatus.waiting,
            dateTime: null,
            message: null);

  ReturnStatusRequestAccepted canceledByCustomer(String message) {
    return ReturnStatusRequestAccepted._(
      status: PurchaseStatus.canceled,
      dateTime: DateTime.now(),
      message: "${AppText.orderPageCanceledByCustomer}: $message",
    );
  }
}

class ReturnStatusShipped extends PurchaseProcess {
  @TestOnly()
  ReturnStatusShipped.testOnly(
      {required super.dateTime,
      required super.status,
      required super.cargoNo,
      super.message})
      : super(
          cancelableWhileProcessing: true,
          purchaseStatusType: ReturnStatusType.shipped,
        );

  ReturnStatusShipped._(
      {required super.dateTime,
      required super.status,
      required super.cargoNo,
      super.message})
      : super(
          cancelableWhileProcessing: true,
          purchaseStatusType: ReturnStatusType.shipped,
        );

  ReturnStatusShipped.waiting()
      : this._(
            status: PurchaseStatus.waiting,
            dateTime: null,
            cargoNo: null,
            message: null);

  ReturnStatusShipped canceledByCustomer(String message) {
    return ReturnStatusShipped._(
        dateTime: DateTime.now(),
        status: PurchaseStatus.canceled,
        message: "${AppText.orderPageCanceledByCustomer}: $message",
        cargoNo: cargoNo);
  }
}

class ReturnStatusDelivered extends PurchaseProcess {
  @TestOnly()
  ReturnStatusDelivered.testOnly({
    required super.message,
    required super.dateTime,
    required super.status,
  }) : super(
          cancelableWhileProcessing: false,
          purchaseStatusType: ReturnStatusType.delivered,
        );

  ReturnStatusDelivered._({
    required super.message,
    required super.dateTime,
    required super.status,
  }) : super(
          cancelableWhileProcessing: false,
          purchaseStatusType: ReturnStatusType.delivered,
        );

  ReturnStatusDelivered.waiting()
      : this._(
            status: PurchaseStatus.waiting,
            dateTime: null,
            message: null);
}

class ReturnStatusReturnAccepted extends PurchaseProcess {
  @TestOnly()
  ReturnStatusReturnAccepted.testOnly({
    required super.message,
    required super.dateTime,
    required super.status,
  }) : super(
          cancelableWhileProcessing: false,
          purchaseStatusType: ReturnStatusType.returnAccepted,
        );

  ReturnStatusReturnAccepted._({
    required super.message,
    required super.dateTime,
    required super.status,
  }) : super(
          cancelableWhileProcessing: false,
          purchaseStatusType: ReturnStatusType.returnAccepted,
        );

  ReturnStatusReturnAccepted.waiting()
      : this._(
            message: null,
            dateTime: null,
            status: PurchaseStatus.waiting);
}

enum ReturnStatusType implements PurchaseStatusType {
  returnRequested('return_requested', AppText.returnsPageReturnRequested),
  returnRequestAccepted('return_accepted', AppText.returnPageRequestAccepted),
  shipped('shipped', AppText.returnsPageReturnShipped),
  delivered('delivered', AppText.returnsPageReturnDelivered),
  returnAccepted('return_accepted', AppText.returnsPageReturnAccepted),
  ;

  ReturnStatusType fromServerMessages(String message) {
    return ReturnStatusType.values
        .firstWhere((element) => element.apiData == message);
  }

  @override
  final String apiData;
  @override
  final AppText userText;

  const ReturnStatusType(this.apiData, this.userText);
}

enum ReturnType {
  unselected(AppText.requestReturnPageSelectReason, 'unselected'),
  damagedProduct(AppText.requestReturnPageDamagedProduct, 'damaged_product'),
  wrongProduct(AppText.requestReturnPageWrongProduct, 'wrong_product'),
  extraProduct(AppText.requestReturnPageExtraProduct, 'extra_product'),
  orderCancelled(AppText.requestReturnPageCanceledOrder, 'canceled_order'),
  other(AppText.requestReturnPageOtherReason, 'other'),
  ;

  final AppText userText;
  final String apiData;

  const ReturnType(this.userText, this.apiData);

  factory ReturnType.fromServerMessage(String message) {
    return ReturnType.values
        .firstWhere((element) => element.apiData == message);
  }
}
