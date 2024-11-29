import 'package:ecommerce_app_mobile/presentation/products/bloc/return_state.dart';

import '../../../data/model/return_process.dart';

class ReturnEvent {}

class RequestReturn extends ReturnEvent {
  final ReturnState returnState;
  final String uid;

  RequestReturn(this.returnState, this.uid);
}

class GetReturns extends ReturnEvent {
  final String uid;

  GetReturns(this.uid);
}

class CancelReturn extends ReturnEvent {
  final Return returnModel;
  final String message;

  CancelReturn(this.returnModel, this.message);
}
