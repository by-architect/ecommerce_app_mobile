import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../data/model/address.dart';
import '../../../data/model/return_process.dart';

class ReturnRequestState extends ReturnState {
  ReturnRequestState({
    required super.products,
    required super.purchaseProcessId,
    required super.userId,
    required super.returnReason,
    required super.returnType,
    required super.returnRequested,
    required super.returnAccepted,
    required super.requestAccepted,
    required super.shipped,
    required super.delivered,
  });

  ReturnRequestState copyWith({
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
    ReturnStatusDelivered? delivered,
  }) {
    return ReturnRequestState(
        products: products ?? this.products,
        purchaseProcessId: purchaseProcessId ?? this.purchaseProcessId,
        userId: userId ?? this.userId,
        returnReason: returnReason ?? this.returnReason,
        returnType: returnType ?? this.returnType,
        returnRequested: returnRequested ?? this.returnRequested,
        returnAccepted: returnAccepted ?? this.returnAccepted,
        requestAccepted: requestAccepted ?? this.requestAccepted,
        shipped: shipped ?? this.shipped,
        delivered: delivered ?? this.delivered);
  }
}

class InitialReturnRequestState extends ReturnRequestState {
  InitialReturnRequestState()
      : super(
            products: [],
            purchaseProcessId: "",
            userId: "",
            returnReason: "",
            returnType: ReturnType.unselected,
            returnRequested: ReturnStatusReturnRequested.create(
                message: "",
                returnType: ReturnType.unselected,
                returnReason: ""),
            returnAccepted: ReturnStatusReturnAccepted.waiting(),
            requestAccepted: ReturnStatusRequestAccepted.waiting(),
            shipped: ReturnStatusShipped.waiting(),
            delivered: ReturnStatusDelivered.waiting());
}

class ReturnRequestLoadingState extends ReturnRequestState {
  final ReturnRequestState state;

  ReturnRequestLoadingState(this.state)
      : super(
            products: state.products,
            purchaseProcessId: state.purchaseProcessId,
            userId: state.userId,
            returnReason: state.returnReason,
            returnType: state.returnType,
            returnRequested: state.returnRequested,
            returnAccepted: state.returnAccepted,
            requestAccepted: state.requestAccepted,
            shipped: state.shipped,
            delivered: state.delivered);
}

class ReturnRequestSuccessState extends ReturnRequestState {
  final ReturnRequestState state;

  ReturnRequestSuccessState(this.state)
      : super(
            products: state.products,
            purchaseProcessId: state.purchaseProcessId,
            userId: state.userId,
            returnReason: state.returnReason,
            returnType: state.returnType,
            returnRequested: state.returnRequested,
            returnAccepted: state.returnAccepted,
            requestAccepted: state.requestAccepted,
            shipped: state.shipped,
            delivered: state.delivered);
}

class ReturnRequestFailState extends ReturnRequestState {
  final ReturnRequestState state;
  final Fail fail;

  ReturnRequestFailState(this.state, this.fail)
      : super(
            products: state.products,
            purchaseProcessId: state.purchaseProcessId,
            userId: state.userId,
            returnReason: state.returnReason,
            returnType: state.returnType,
            returnRequested: state.returnRequested,
            returnAccepted: state.returnAccepted,
            requestAccepted: state.requestAccepted,
            shipped: state.shipped,
            delivered: state.delivered);
}
