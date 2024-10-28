import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/service/impl/user_service_impl.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserService userService = UserServiceImpl();

  SignUpBloc() : super(SignUpInitState()) {
    on<NameEvent>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<SurnameEvent>((event, emit) {
      emit(state.copyWith(surname: event.surname));
    });

    on<EmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<PasswordConfirmEvent>((event, emit) {
      emit(state.copyWith(passwordConfirm: event.passwordConfirm));
    });

    on<BirthYearEvent>((event, emit) {
      emit(state.copyWith(birthYear: event.birthYear));
    });

    on<GenderEvent>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<SignUpRequestEvent>((event, emit) async {
      emit(SignUpRequestLoadingState(state.copyWith()));
      final resource = await userService.addUser(state);

      if (resource.isSuccess) {
        emit(SignUpRequestSuccessState(state: state.copyWith(), user: resource.data!));
      }
      else{
        emit(SignUpRequestFailState(state: state.copyWith(), fail: resource.error!));
      }

    });
  }
}
