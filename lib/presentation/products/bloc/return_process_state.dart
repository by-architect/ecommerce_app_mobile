import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';

class ReturnProcessState {
  final List<SelectedProduct> selectedProducts;

  const ReturnProcessState({
    required this.selectedProducts,
  });


  Map<String, dynamic> toMap() {
    return {
      ApiDeliveryProcesses.selectedProducts: selectedProducts.map((e) => e.toMap()).toList(),
    };
  }
}

class ReturnStatusState {
  final String? message;
  final Object? receipt;
  final String returnStatusType;
  final String dateTime;

  const ReturnStatusState({
    this.message,
    this.receipt,
    required this.returnStatusType,
    required this.dateTime,
  });


  Map<String, dynamic> toMap() {
    return {
      ApiDeliveryProcesses.message: message,
      ApiDeliveryProcesses.receipt: receipt,
      ApiDeliveryProcesses.returnStatusType: returnStatusType,
      ApiDeliveryProcesses.dateTime: dateTime,
    };
  }
}
