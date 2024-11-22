import 'package:ecommerce_app_mobile/data/model/return_process.dart';

import '../../../../sddklibrary/util/fail.dart';

class ReturnState {
  final List<ReturnProcess> returns;

  ReturnState({required this.returns});

  ReturnState copyWith({List<ReturnProcess>? returns}) {
    return ReturnState(returns: returns ?? this.returns);
  }
}

class ReturnInitial extends ReturnState {
  ReturnInitial() : super(returns: []);
}

class ReturnsLoadingState extends ReturnState {
  final ReturnState state;

  ReturnsLoadingState(this.state) : super(returns: state.returns);
}

class ReturnsSuccessState extends ReturnState {
  final ReturnState state;

  ReturnsSuccessState(this.state) : super(returns: state.returns);
}

class ReturnsFailedState extends ReturnState {
  final Fail fail;
  final ReturnState state;

  ReturnsFailedState(this.state, this.fail) : super(returns: state.returns);
}

class CancelReturnSuccessState extends ReturnState {
  final ReturnState state;

  CancelReturnSuccessState(this.state) : super(returns: state.returns);
}

class CancelReturnFailedState extends ReturnState {
  final Fail fail;

  final ReturnState state;

  CancelReturnFailedState(this.state, this.fail)
      : super(returns: state.returns);
}

class CancelReturnLoadingState extends ReturnState {
  final ReturnState state;

  CancelReturnLoadingState(this.state) : super(returns: state.returns);
}

class RequestReturnLoadingState extends ReturnState {
  final ReturnState state;

  RequestReturnLoadingState(this.state) : super(returns: state.returns);
}

class RequestReturnSuccessState extends ReturnState {
  final ReturnState state;

  RequestReturnSuccessState(this.state) : super(returns: state.returns);
}

class RequestReturnFailedState extends ReturnState {
  final Fail fail;
  final ReturnState state;

  RequestReturnFailedState(this.state, this.fail)
      : super(returns: state.returns);
}
