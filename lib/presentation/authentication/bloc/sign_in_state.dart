import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../../data/model/user.dart';

class SignInState {
  final String email;
  final String password;

  SignInState({
    required this.email,
    required this.password,
  });

  SignInState copyWith({
    String? email,
    String? password,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class SignInInitState extends SignInState {
  SignInInitState() : super(email: '', password: '');
}

class SignInLoadingState extends SignInState {
  final SignInState state;

  SignInLoadingState(this.state) : super(email: state.email, password: state.password);
}

class SignInFailState extends SignInState {
  final Fail fail;
  final SignInState state;

  SignInFailState({required this.fail, required this.state})
      : super(email: state.email, password: state.password);
}

class SignInSuccessState extends SignInState {
  final SignInState state;
  final User user;

  SignInSuccessState({required this.state, required this.user}) : super(email: state.email, password: state.password);
}
