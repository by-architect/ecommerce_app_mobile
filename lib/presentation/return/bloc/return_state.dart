import 'package:ecommerce_app_mobile/data/model/address.dart';

import '../../../data/model/product.dart';
import '../../../data/model/return_process.dart';

class ReturnState {
  final List<ProductWithQuantity> products;
  final String purchaseProcessId;
  final String userId;
  final String returnReason;
  final ReturnType returnType;
  final Address? address;
  final ReturnStatusReturnRequested returnRequested;
  final ReturnStatusReturnAccepted returnAccepted;
  final ReturnStatusRequestAccepted requestAccepted;
  final ReturnStatusShipped shipped;
  final ReturnStatusDelivered delivered;

  ReturnState({
    required this.products,
    required this.returnRequested,
    required this.returnAccepted,
    required this.requestAccepted,
    required this.shipped,
    required this.delivered,
    required this.address,
    required this.returnType,
    required this.returnReason,
    required this.userId,
    required this.purchaseProcessId,
  });

/*
  ReturnState copyWith(
      List<ProductWithQuantity>? products,
      String? purchaseProcessId,
      String? userId,
      String? returnReason,
      ReturnType? returnType,
      Address? address,
      ReturnStatusReturnRequested? returnRequested,
      ReturnStatusReturnAccepted? returnAccepted,
      ReturnStatusRequestAccepted? requestAccepted,
      ReturnStatusShipped? shipped,
      ReturnStatusDelivered? delivered) {
    return ReturnState(
        products: products ?? this.products,
        purchaseProcessId: purchaseProcessId ?? this.purchaseProcessId,
        userId: userId ?? this.userId,
        returnReason: returnReason ?? this.returnReason,
        returnType: returnType ?? this.returnType,
        address: address ?? this.address,
        returnRequested: returnRequested ?? this.returnRequested,
        returnAccepted: returnAccepted ?? this.returnAccepted,
        requestAccepted: requestAccepted ?? this.requestAccepted,
        shipped: shipped ?? this.shipped,
        delivered: delivered ?? this.delivered);
*/
}

Map<String, dynamic> toMap() {
  return {
    //todo: unimplemented
  };
}
