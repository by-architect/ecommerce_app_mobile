import 'package:ecommerce_app_mobile/data/model/address.dart';

import '../../../data/model/product.dart';
import '../../../data/model/return_process.dart';

class ReturnState {
  final List<ProductWithQuantity> products;
  final String purchaseProcessId;
  final String userId;
  final String returnReason;
  final ReturnType returnType;
  final Address address;
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

  Map<String, dynamic> toMap() {
    return {
      //todo: unimplemented
    };
  }
}
