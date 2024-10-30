import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';

class PurchaseProcess {
  final String id;
  final String uid;
  final List<PurchaseStatus> processStatusList;
  final List<SelectedProduct> selectedProducts;
  final String cargoNo;

  PurchaseProcess({required this.id,
    required this.uid,
    required this.selectedProducts,
    required this.processStatusList,
    required this.cargoNo});

  PurchaseProcess.fromMap(Map<String, dynamic> map,this.id)
      : uid = map[ApiDeliveryProcesses.uid],
        processStatusList = (map[ApiDeliveryProcesses.processStatusList] as List).map((e) => PurchaseStatus.fromMap(e)).toList(),
        selectedProducts = (map[ApiDeliveryProcesses.selectedProducts] as List).map((e) => SelectedProduct.fromMap(e)).toList(),
        cargoNo = map[ApiDeliveryProcesses.cargoNo];
}

class PurchaseStatus {
  final String? message;
  final Object? receipt;
  final PurchaseStatusType purchaseStatusType;
  final DateTime dateTime;

  PurchaseStatus({this.message,
    this.receipt,
    required this.purchaseStatusType,
    required this.dateTime,
  });

  PurchaseStatus.fromMap(Map<String, dynamic> map,)
      :
        message = map[ApiDeliveryProcesses.message],
        receipt = map[ApiDeliveryProcesses.receipt],
        purchaseStatusType = PurchaseStatusType.fromServerMessage(map[ApiDeliveryProcesses.purchaseStatusType]),
        dateTime = DateTime.parse(map[ApiDeliveryProcesses.dateTime]);
}

enum PurchaseStatusType {
  purchaseProcessStarted(ApiDeliveryProcesses.purchaseProcessStarted),
  payingFailed(ApiDeliveryProcesses.payingFailed),
  payingSuccess(ApiDeliveryProcesses.payingSuccess),
  orderTaken(ApiDeliveryProcesses.orderTaken),
  canceledByStore(ApiDeliveryProcesses.canceledByStore),
  canceledByCustomer(ApiDeliveryProcesses.canceledByCustomer),
  moneyReturned(ApiDeliveryProcesses.moneyReturned),
  shipped(ApiDeliveryProcesses.shipped),
  delivered(ApiDeliveryProcesses.delivered),
  deliverFailed(ApiDeliveryProcesses.deliverFailed),
  purchaseProcessFinished(ApiDeliveryProcesses.purchaseProcessFinished),
  ;

  static PurchaseStatusType fromServerMessage(String message) {
    return PurchaseStatusType.values.firstWhere((element) => element.apiData == message);
  }

  final String apiData;

  const PurchaseStatusType(this.apiData);
}

class SelectedProduct {
  final String subProductId;
  final int quantity;

  SelectedProduct({required this.subProductId, required this.quantity});

  factory SelectedProduct.fromMap(Map<String, dynamic> map) {
    return SelectedProduct(
        subProductId: map[ApiDeliveryProcesses.subProductId], quantity: map[ApiDeliveryProcesses.quantity]);
  }

  Map<String, dynamic> toMap() {
    return {ApiDeliveryProcesses.subProductId: subProductId, ApiDeliveryProcesses.quantity: quantity};
  }
}
