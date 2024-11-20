import '../../../common/constant/api_constants.dart';
import '../../../data/model/product.dart';
import '../../../data/model/purchase_process.dart';

class PurchaseProcessState {
  final List<PurchaseStatus> processStatusList;
  final List<ProductWithQuantity> selectedProducts;
  final String cargoNo;

  PurchaseProcessState({required this.processStatusList, required this.selectedProducts, required this.cargoNo});

  Map<String, dynamic> toMap() {
    return {
      //todo: unimplemented
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
