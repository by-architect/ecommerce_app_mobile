import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserRequestState> {
  UserBloc() : super(InitUserRequestState()) {
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
    on<GenderEvent>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<BirthYearEvent>((event, emit) {
      emit(state.copyWith(birthYear: event.birthYear));
    });
  }
}
