import 'package:ecommerce_app_mobile/common/constant/api_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';

class PurchaseProcess {
  final String id;
  final String uid;
  final List<PurchaseStatus> processStatusList;
  final List<ProductWithQuantity> selectedProducts;
  final String cargoNo;

  PurchaseProcess(
      {required this.id,
      required this.uid,
      required this.selectedProducts,
      required this.processStatusList,
      required this.cargoNo});

  List<PurchaseStatusType> get processStatusListRoadMap {
    return processStatusList
        .map((e) => e.purchaseStatusType)
        .where((e) =>
            e != PurchaseStatusType.purchaseProcessStarted &&
            e != PurchaseStatusType.payingFailed &&
            e != PurchaseStatusType.purchaseProcessFinished)
        .toList();
  }

  List<PurchaseStatusType> get processStatusRemainedRoadMap {
    switch (processStatusList.last.purchaseStatusType) {
      case PurchaseStatusType.canceledByStore || PurchaseStatusType.canceledByCustomer:
        return [PurchaseStatusType.moneyReturned];

      case PurchaseStatusType.deliverFailed:
        return [PurchaseStatusType.shipped, PurchaseStatusType.delivered];

      case PurchaseStatusType.payingSuccess:
        return [PurchaseStatusType.orderTaken, PurchaseStatusType.shipped, PurchaseStatusType.delivered];

      case PurchaseStatusType.orderTaken:
        return [PurchaseStatusType.shipped, PurchaseStatusType.delivered];

      case PurchaseStatusType.shipped:
        return [PurchaseStatusType.delivered];

      case PurchaseStatusType.delivered || PurchaseStatusType.moneyReturned:
        return [];

      case PurchaseStatusType.purchaseProcessStarted ||
            PurchaseStatusType.purchaseProcessFinished ||
            PurchaseStatusType.payingFailed:
        return [];
    }
  }

  PurchaseProcess.fromMap(Map<String, dynamic> map, this.id)
      : uid = map[ApiDeliveryProcesses.uid],
        processStatusList =
            (map[ApiDeliveryProcesses.processStatusList] as List).map((e) => PurchaseStatus.fromMap(e)).toList(),
        selectedProducts =
            (map[ApiDeliveryProcesses.selectedProducts] as List).map((e) => ProductWithQuantity.fromMap(e)).toList(),
        cargoNo = map[ApiDeliveryProcesses.cargoNo];
}

class PurchaseStatus {
  final String? message;
  final Object? receipt;
  final PurchaseStatusType purchaseStatusType;
  final DateTime dateTime;

  PurchaseStatus({
    this.message,
    this.receipt,
    required this.purchaseStatusType,
    required this.dateTime,
  });

  PurchaseStatus.fromMap(
    Map<String, dynamic> map,
  )   : message = map[ApiDeliveryProcesses.message],
        receipt = map[ApiDeliveryProcesses.receipt],
        purchaseStatusType = PurchaseStatusType.fromServerMessage(map[ApiDeliveryProcesses.purchaseStatusType]),
        dateTime = DateTime.parse(map[ApiDeliveryProcesses.dateTime]);
}

enum PurchaseStatusType {
  purchaseProcessStarted(ApiDeliveryProcesses.purchaseProcessStarted, AppText.orderPagePurchaseProcessStarted),
  payingFailed(ApiDeliveryProcesses.payingFailed, AppText.orderPagePayingFailed),
  payingSuccess(ApiDeliveryProcesses.payingSuccess, AppText.orderPagePayingSuccess),
  orderTaken(ApiDeliveryProcesses.orderTaken, AppText.orderPageOrderTaken),
  canceledByStore(ApiDeliveryProcesses.canceledByStore, AppText.orderPageCanceledByStore),
  canceledByCustomer(ApiDeliveryProcesses.canceledByCustomer, AppText.orderPageCanceledByCustomer),
  moneyReturned(ApiDeliveryProcesses.moneyReturned, AppText.orderPageMoneyReturned),
  shipped(ApiDeliveryProcesses.shipped, AppText.orderPageShipped),
  delivered(ApiDeliveryProcesses.delivered, AppText.orderPageDelivered),
  deliverFailed(ApiDeliveryProcesses.deliverFailed, AppText.orderPageDeliverFailed),
  purchaseProcessFinished(ApiDeliveryProcesses.purchaseProcessFinished, AppText.orderPagePurchaseProcessFinished),
  ;

  static PurchaseStatusType fromServerMessage(String message) {
    return PurchaseStatusType.values.firstWhere((element) => element.apiData == message);
  }

  final String apiData;
  final AppText userText;

  const PurchaseStatusType(this.apiData, this.userText);
}
