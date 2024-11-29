import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';

class Return implements Purchase {
  @override
  final String id;
  @override
  final String uid;
  final String purchaseProcessId;
  @override
  final List<ProductWithQuantity> products;
  @override
  final Address address;

  final ReturnStatusReturnRequested statusReturnRequested;
  final ReturnStatusRequestAccepted statusRequestAccepted;
  final ReturnStatusShipped statusReturnShipped;
  final ReturnStatusDelivered statusReturnDelivered;
  final ReturnStatusReturnAccepted statusReturnAccepted;

  Return({
    required this.id,
    required this.purchaseProcessId,
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

  Return? cancelReturn(String message) {
    final processing = getProcessing;
    if (processing == null) return null;
    if (processing is ReturnStatusRequestAccepted) {
      return Return(
          id: id,
          purchaseProcessId: purchaseProcessId,
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
      return Return(
          id: id,
          purchaseProcessId: purchaseProcessId,
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

  ReturnStatusReturnRequested({
    required super.message,
    required this.returnReason,
    required this.returnType,
    required super.dateTime,
  }) : super(
          cancelableWhileProcessing: false,
          status: PurchaseStatus.success,
          purchaseStatusType: ReturnStatusType.returnRequested,
        );
}

class ReturnStatusRequestAccepted extends PurchaseProcess {
  ReturnStatusRequestAccepted(
      {required super.message, required super.dateTime, required super.status})
      : super(
          cancelableWhileProcessing: true,
          purchaseStatusType: ReturnStatusType.returnRequestAccepted,
        );

  ReturnStatusRequestAccepted.waiting()
      : this(
            status: PurchaseStatus.waiting,
            dateTime: DateTime.now(),
            message: null);

  ReturnStatusRequestAccepted canceledByCustomer(String message) {
    return ReturnStatusRequestAccepted(
      status: PurchaseStatus.canceled,
      dateTime: DateTime.now(),
      message: "${AppText.orderPageCanceledByCustomer}: $message",
    );
  }
}

class ReturnStatusShipped extends PurchaseProcess {
  ReturnStatusShipped(
      {required super.dateTime,
      required super.status,
      required super.cargoNo,
      super.message})
      : super(
          cancelableWhileProcessing: true,
          purchaseStatusType: ReturnStatusType.shipped,
        );

  ReturnStatusShipped.waiting()
      : this(
            status: PurchaseStatus.waiting,
            dateTime: DateTime.now(),
            cargoNo: null,
            message: null);

  ReturnStatusShipped canceledByCustomer(String message) {
    return ReturnStatusShipped(
        dateTime: DateTime.now(),
        status: PurchaseStatus.canceled,
        message: "${AppText.orderPageCanceledByCustomer}: $message",
        cargoNo: cargoNo);
  }
}

class ReturnStatusDelivered extends PurchaseProcess {
  ReturnStatusDelivered({
    required super.message,
    required super.dateTime,
    required super.status,
  }) : super(
          cancelableWhileProcessing: false,
          purchaseStatusType: ReturnStatusType.delivered,
        );

  ReturnStatusDelivered.waiting()
      : this(
            status: PurchaseStatus.waiting,
            dateTime: DateTime.now(),
            message: null);
}

class ReturnStatusReturnAccepted extends PurchaseProcess {
  ReturnStatusReturnAccepted({
    required super.message,
    required super.dateTime,
    required super.status,
  }) : super(
          cancelableWhileProcessing: false,
          purchaseStatusType: ReturnStatusType.returnAccepted,
        );

  ReturnStatusReturnAccepted.waiting()
      : this(
            message: null,
            dateTime: DateTime.now(),
            status: PurchaseStatus.waiting);
}

enum ReturnStatusType implements PurchaseStatusType {
  returnRequested('return_requested', AppText.returnsPageReturnRequested),
  returnRequestAccepted('return_accepted', AppText.returnsPageReturnAccepted),
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
