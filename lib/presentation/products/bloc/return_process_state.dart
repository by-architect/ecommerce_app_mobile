import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';

import '../../../data/model/product.dart';
import '../../../data/model/return_process.dart';

class ReturnProcessState {
  final List<ReturnStatus> processStatusList;
  final List<ProductWithQuantity> selectedProducts;
  final String cargoNo;
  final String purchaseProcessId;

  ReturnProcessState({
    required this.processStatusList,
    required this.selectedProducts,
    required this.cargoNo,
    required this.purchaseProcessId,
  });

  Map<String, dynamic> toMap() {
    return {
      //todo: unimplemented
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
