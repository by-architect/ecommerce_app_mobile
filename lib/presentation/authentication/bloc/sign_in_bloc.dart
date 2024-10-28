import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sddklibrary/util/resource.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserService userService = UserServiceImpl();
  SignInBloc() : super(SignInInitState()) {
    on<EmailEvent>(
      (event, emit) {
        emit(state.copyWith(email: event.username));
      },
    );
    on<PasswordEvent>(
      (event, emit) {
        emit(state.copyWith(password: event.password));
      },
    );
    on<SignInRequestEvent>(
      (event, emit) async {
        emit(SignInLoadingState(state.copyWith()));

        final userLoginResource = await userService.signIn(state);
        switch(userLoginResource.status){

          case Status.success:
            emit(SignInSuccessState(user: userLoginResource.data!,state: state.copyWith()));
            break;
          case Status.fail:
            emit(SignInFailState(fail: userLoginResource.error!,state: state.copyWith()));
            break;
          case Status.loading:
            emit(SignInLoadingState(state.copyWith()));
            break;
          case Status.stable:
            break;
        }
      },
    );
  }
}
