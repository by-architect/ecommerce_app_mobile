import 'package:ecommerce_app_mobile/presentation/products/bloc/return_process_state.dart';

class ReturnEvent {}

class RequestReturn extends ReturnEvent {
  final ReturnProcessState returnState;
  final String uid;

  RequestReturn(this.returnState, this.uid);
}

class GetReturns extends ReturnEvent {
  final String uid;

  GetReturns(this.uid);
}

class CancelReturn extends ReturnEvent {
  final String returnId;

  CancelReturn(this.returnId);
}
