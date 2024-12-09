import 'package:ecommerce_app_mobile/data/model/return_process.dart';

import '../../../data/model/product.dart';

class ReturnRequestsEvent {}

class RequestReturnEvent extends ReturnRequestsEvent {}

class ReturnTypeEvent extends ReturnRequestsEvent {
  final ReturnType returnType;

  ReturnTypeEvent(this.returnType);
}

class ReturnReasonEvent extends ReturnRequestsEvent {
  final String returnReason;

  ReturnReasonEvent(this.returnReason);
}

class SelectedProductEvent extends ReturnRequestsEvent {
  final ProductWithQuantity product;
  final int index;

  SelectedProductEvent({required this.product, required this.index});
}

class InitialProductsEvent extends ReturnRequestsEvent {
  final List<ProductWithQuantity> products;

  InitialProductsEvent({required this.products});
}

class ClearReturnStateEvent extends ReturnRequestsEvent {}
