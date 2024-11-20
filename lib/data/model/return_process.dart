import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';

class ReturnProcess {
  final String id;
  final String uid;
  final List<ReturnStatus> processStatusList;
  final List<ProductWithQuantity> selectedProducts;
  final String cargoNo;
  final String purchaseProcessId;

  ReturnProcess(
      {required this.id,
      required this.purchaseProcessId,
      required this.selectedProducts,
      required this.uid,
      required this.processStatusList,
      required this.cargoNo});

  factory ReturnProcess.fromMap(
      {required Map<String, dynamic> map, required String id, required List<ReturnStatus> processStatusList}) {
    return ReturnProcess(
      id: id,
      purchaseProcessId: map[ApiDeliveryProcesses.purchaseProcessId],
      uid: map[ApiDeliveryProcesses.uid],
      processStatusList: processStatusList,
      selectedProducts:
          (map[ApiDeliveryProcesses.selectedProducts] as List).map((e) => ProductWithQuantity.fromMap(e)).toList(),
      cargoNo: map[ApiDeliveryProcesses.cargoNo],
    );
  }
}

class ReturnStatus {
  final Object? receipt;
  final ReturnProcessStatusType status;
  final DateTime dateTime;
  final String? message;

  ReturnStatus({this.receipt, required this.status, required this.dateTime, this.message});

  factory ReturnStatus.fromMap({required Map<String, dynamic> map}) {
    return ReturnStatus(
      receipt: map[ApiDeliveryProcesses.receipt],
      status: ReturnProcessStatusType.fromServerMessage(map[ApiDeliveryProcesses.returnStatusType]),
      dateTime: DateTime.parse(map[ApiDeliveryProcesses.dateTime]),
      message: map[ApiDeliveryProcesses.message],
    );
  }
}

enum ReturnProcessStatusType {
  returnProcessStarted(ApiDeliveryProcesses.returnProcessStarted),
  returnRequested(ApiDeliveryProcesses.returnRequested),
  returnStarted(ApiDeliveryProcesses.returnStarted),
  returnRejected(ApiDeliveryProcesses.returnRejected),
  canceledByCustomer(ApiDeliveryProcesses.canceledByCustomer),
  canceledByStore(ApiDeliveryProcesses.canceledByStore),
  shipped(ApiDeliveryProcesses.shipped),
  delivered(ApiDeliveryProcesses.delivered),
  deliverFailed(ApiDeliveryProcesses.deliverFailed),
  moneyReturned(ApiDeliveryProcesses.moneyReturned),
  returnProcessFinished(ApiDeliveryProcesses.returnProcessFinished),
  ;

  final String apiData;

  const ReturnProcessStatusType(this.apiData);

  factory ReturnProcessStatusType.fromServerMessage(String message) {
    return ReturnProcessStatusType.values.firstWhere((element) => element.apiData == message);
  }
}
