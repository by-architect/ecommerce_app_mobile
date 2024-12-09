import 'package:ecommerce_app_mobile/presentation/return/bloc/return_state.dart';

import '../../../data/model/return_process.dart';

class ReturnEvent {}

class RequestReturn extends ReturnEvent {
  final ReturnState returnState;
  final String uid;

  RequestReturn(this.returnState, this.uid);
}

class GetReturnsEvent extends ReturnEvent {
  final String uid;

  GetReturnsEvent(this.uid);
}

class CancelReturnEvent extends ReturnEvent {
  final ReturnModel returnModel;
  final String message;
  final String uid;

  CancelReturnEvent({required this.returnModel, required this.message, required this.uid});
}
