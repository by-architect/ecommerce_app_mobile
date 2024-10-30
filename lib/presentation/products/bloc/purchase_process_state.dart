import '../../../common/constant/api_constants.dart';
import '../../../data/model/purchase_process.dart';

class PurchaseProcessState {
  final String productId;
  final String subProductId;
  final int quantity;

  PurchaseProcessState({required this.productId, required this.subProductId, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      ApiDeliveryProcesses.productId: productId,
      ApiDeliveryProcesses.subProductId: subProductId,
      ApiDeliveryProcesses.quantity: quantity
    };
  }
}

class PurchaseStatusState {
  final String purchaseProcessId;
  final String? message;
  final Object? receipt;
  final PurchaseStatusType purchaseStatusType;
  final DateTime dateTime;

  PurchaseStatusState(
      {required this.purchaseProcessId,
      this.message,
      this.receipt,
      required this.purchaseStatusType,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      ApiDeliveryProcesses.purchaseProcessId: purchaseProcessId,
      ApiDeliveryProcesses.message: message,
      ApiDeliveryProcesses.receipt: receipt,
      ApiDeliveryProcesses.purchaseStatusType: purchaseStatusType.name,
      ApiDeliveryProcesses.dateTime: dateTime.toIso8601String(),
    };
  }
}
