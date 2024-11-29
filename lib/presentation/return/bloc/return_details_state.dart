import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../data/model/address.dart';
import '../../../data/model/return_process.dart';

class ReturnDetailsState extends ReturnState {
  ReturnDetailsState({
    required super.products,
    required super.purchaseProcessId,
    required super.userId,
    required super.returnReason,
    required super.returnType,
    required super.address,
    required super.returnRequested,
    required super.returnAccepted,
    required super.requestAccepted,
    required super.shipped,
    required super.delivered,
  });

  ReturnDetailsState copyWith({
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
    return ReturnDetailsState(
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
  }
}

class InitialReturnState extends ReturnDetailsState {
  InitialReturnState()
      : super(
      products: [],
      purchaseProcessId: "",
      userId: "",
      returnReason: "",
      returnType: ReturnType.values.first,
      address: null,
      returnRequested: ReturnStatusReturnRequested(
          message: "",
          returnType: ReturnType.values.first,
          returnReason: "",
          dateTime: DateTime.now()),
      returnAccepted: ReturnStatusReturnAccepted.waiting(),
      requestAccepted: ReturnStatusRequestAccepted.waiting(),
      shipped: ReturnStatusShipped.waiting(),
      delivered: ReturnStatusDelivered.waiting());
}

class ReturnRequestLoadingState extends ReturnDetailsState {
  final ReturnDetailsState state;

  ReturnRequestLoadingState(this.state)
      : super(
      products: state.products,
      purchaseProcessId: state.purchaseProcessId,
      userId: state.userId,
      returnReason: state.returnReason,
      returnType: state.returnType,
      address: state.address,
      returnRequested: state.returnRequested,
      returnAccepted: state.returnAccepted,
      requestAccepted: state.requestAccepted,
      shipped: state.shipped,
      delivered: state.delivered);
}

class ReturnRequestSuccessState extends ReturnDetailsState {
  final ReturnDetailsState state;

  ReturnRequestSuccessState(this.state)
      : super(
      products: state.products,
      purchaseProcessId: state.purchaseProcessId,
      userId: state.userId,
      returnReason: state.returnReason,
      returnType: state.returnType,
      address: state.address,
      returnRequested: state.returnRequested,
      returnAccepted: state.returnAccepted,
      requestAccepted: state.requestAccepted,
      shipped: state.shipped,
      delivered: state.delivered);
}

class ReturnRequestFailState extends ReturnDetailsState {
  final ReturnDetailsState state;
  final Fail fail;

  ReturnRequestFailState(this.state, this.fail)
      : super(
      products: state.products,
      purchaseProcessId: state.purchaseProcessId,
      userId: state.userId,
      returnReason: state.returnReason,
      returnType: state.returnType,
      address: state.address,
      returnRequested: state.returnRequested,
      returnAccepted: state.returnAccepted,
      requestAccepted: state.requestAccepted,
      shipped: state.shipped,
      delivered: state.delivered);
}
