import 'package:ecommerce_app_mobile/data/model/return_process.dart';

import '../../../../sddklibrary/util/fail.dart';

class ReturnsState {
  final List<ReturnModel> returns;

  ReturnsState({required this.returns});

  ReturnsState copyWith({List<ReturnModel>? returns}) {
    return ReturnsState(returns: returns ?? this.returns);
  }
}

class ReturnsInitialState extends ReturnsState {
  ReturnsInitialState() : super(returns: []);
}

class ReturnsLoadingState extends ReturnsState {
  final ReturnsState state;

  ReturnsLoadingState(this.state) : super(returns: state.returns);
}

class ReturnsSuccessState extends ReturnsState {
  final ReturnsState state;

  ReturnsSuccessState(this.state) : super(returns: state.returns);
}

class ReturnsFailedState extends ReturnsState {
  final Fail fail;
  final ReturnsState state;

  ReturnsFailedState(this.state, this.fail) : super(returns: state.returns);
}

class CancelReturnSuccessState extends ReturnsState {
  final ReturnsState state;

  CancelReturnSuccessState(this.state) : super(returns: state.returns);
}

class CancelReturnFailedState extends ReturnsState {
  final Fail fail;

  final ReturnsState state;

  CancelReturnFailedState(this.state, this.fail)
      : super(returns: state.returns);
}

class CancelReturnLoadingState extends ReturnsState {
  final ReturnsState state;

  CancelReturnLoadingState(this.state) : super(returns: state.returns);
}

/*
class RequestReturnLoadingState extends ReturnsState {
  final ReturnsState state;

  RequestReturnLoadingState(this.state) : super(returns: state.returns);
}

class RequestReturnSuccessState extends ReturnsState {
  final ReturnsState state;

  RequestReturnSuccessState(this.state) : super(returns: state.returns);
}

class RequestReturnFailedState extends ReturnsState {
  final Fail fail;
  final ReturnsState state;

  RequestReturnFailedState(this.state, this.fail)
      : super(returns: state.returns);
}
*/
