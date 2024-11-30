import 'package:ecommerce_app_mobile/data/model/return_process.dart';

import '../../../data/model/product.dart';

class ReturnDetailsEvent {}

class RequestReturnEvent extends ReturnDetailsEvent {}

class ReturnTypeEvent extends ReturnDetailsEvent {
  final ReturnType returnType;

  ReturnTypeEvent(this.returnType);
}

class ReturnReasonEvent extends ReturnDetailsEvent {
  final String returnReason;

  ReturnReasonEvent(this.returnReason);
}

class SelectedProductEvent extends ReturnDetailsEvent {
  final ProductWithQuantity product;
  final int index;

  SelectedProductEvent({required this.product, required this.index});
}

class InitialProductsEvent extends ReturnDetailsEvent {
  final List<ProductWithQuantity> products;

  InitialProductsEvent({required this.products});
}

class ClearReturnStateEvent extends ReturnDetailsEvent {}
