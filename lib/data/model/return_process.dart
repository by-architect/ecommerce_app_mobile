import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';

class ReturnProcess {
  final String id;
  final String uid;
  final List<ReturnStatus> processStatusList;
  final List<ProductWithQuantity> selectedProducts;
  final String cargoNo;
  final String purchaseProcessId;

  List<ReturnProcessStatusType> get returnStatusListRoadMap => processStatusList
      .map((e) => e.status)
      .where((element) =>
          element != ReturnProcessStatusType.returnProcessStarted &&
          element != ReturnProcessStatusType.returnProcessFinished)
      .toList();

  List<ReturnProcessStatusType> get returnStatusRemainedRoadMap {
    switch (processStatusList.last.status) {
      case ReturnProcessStatusType.returnRequested:
        return [
          ReturnProcessStatusType.returnAccepted,
          ReturnProcessStatusType.returnProcessStarted,
          ReturnProcessStatusType.shipped,
          ReturnProcessStatusType.delivered,
          ReturnProcessStatusType.moneyReturned
        ];
      case ReturnProcessStatusType.returnAccepted:
        return [
          ReturnProcessStatusType.returnProcessStarted,
          ReturnProcessStatusType.shipped,
          ReturnProcessStatusType.delivered,
          ReturnProcessStatusType.moneyReturned
        ];
      case ReturnProcessStatusType.returnRejected:
        return [];
      case ReturnProcessStatusType.returnProcessStarted:
        return [
          ReturnProcessStatusType.shipped,
          ReturnProcessStatusType.delivered,
          ReturnProcessStatusType.moneyReturned
        ];
      case ReturnProcessStatusType.shipped:
        return [
          ReturnProcessStatusType.delivered,
          ReturnProcessStatusType.moneyReturned
        ];
      case ReturnProcessStatusType.delivered:
        return [ReturnProcessStatusType.moneyReturned];
      case ReturnProcessStatusType.moneyReturned:
        return [];
      case ReturnProcessStatusType.deliverFailed:
        return [
          ReturnProcessStatusType.shipped,
          ReturnProcessStatusType.delivered,
          ReturnProcessStatusType.moneyReturned
        ];
      case ReturnProcessStatusType.canceledByCustomer ||
            ReturnProcessStatusType.canceledByStore:
        return [];
      default:
        return [];
    }
  }

  ReturnProcess(
      {required this.id,
      required this.purchaseProcessId,
      required this.selectedProducts,
      required this.uid,
      required this.processStatusList,
      required this.cargoNo});

  factory ReturnProcess.fromMap(
      {required Map<String, dynamic> map,
      required String id,
      required List<ReturnStatus> processStatusList}) {
    return ReturnProcess(
      id: id,
      purchaseProcessId: map[ApiDeliveryProcesses.purchaseProcessId],
      uid: map[ApiDeliveryProcesses.uid],
      processStatusList: processStatusList,
      selectedProducts: (map[ApiDeliveryProcesses.selectedProducts] as List)
          .map((e) => ProductWithQuantity.fromMap(e))
          .toList(),
      cargoNo: map[ApiDeliveryProcesses.cargoNo],
    );
  }
}

class ReturnStatus {
  final Object? receipt;
  final ReturnProcessStatusType status;
  final DateTime dateTime;
  final String? message;

  ReturnStatus(
      {this.receipt,
      required this.status,
      required this.dateTime,
      this.message});

  factory ReturnStatus.fromMap({required Map<String, dynamic> map}) {
    return ReturnStatus(
      receipt: map[ApiDeliveryProcesses.receipt],
      status: ReturnProcessStatusType.fromServerMessage(
          map[ApiDeliveryProcesses.returnStatusType]),
      dateTime: DateTime.parse(map[ApiDeliveryProcesses.dateTime]),
      message: map[ApiDeliveryProcesses.message],
    );
  }
}

enum ReturnProcessStatusType {
  returnProcessStarted(ApiDeliveryProcesses.returnProcessStarted, AppText.orderPageReturnProcessStarted),
  returnRequested(ApiDeliveryProcesses.returnRequested, AppText.orderPageReturnRequested),
  returnAccepted(ApiDeliveryProcesses.returnAccepted, AppText.orderPageReturnAccepted),
  returnRejected(ApiDeliveryProcesses.returnRejected, AppText.orderPageReturnRejected),
  shipped(ApiDeliveryProcesses.shipped, AppText.orderPageShipped),
  delivered(ApiDeliveryProcesses.delivered, AppText.orderPageDelivered),
  moneyReturned(ApiDeliveryProcesses.moneyReturned, AppText.orderPageMoneyReturned),
  canceledByCustomer(ApiDeliveryProcesses.canceledByCustomer, AppText.orderPageCanceledByCustomer),
  canceledByStore(ApiDeliveryProcesses.canceledByStore, AppText.orderPageCanceledByStore),
  deliverFailed(ApiDeliveryProcesses.deliverFailed, AppText.orderPageDeliverFailed),
  returnProcessFinished(ApiDeliveryProcesses.returnProcessFinished, AppText.orderPageReturnProcessFinished),
  ;

  final String apiData;
  final AppText userText;

  const ReturnProcessStatusType(this.apiData,this.userText);

  factory ReturnProcessStatusType.fromServerMessage(String message) {
    return ReturnProcessStatusType.values
        .firstWhere((element) => element.apiData == message);
  }
}
