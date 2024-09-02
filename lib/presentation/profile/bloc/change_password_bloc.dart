import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_event.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(InitChangePasswordState()) {
    final service = UserServiceImpl();
    on<OldPasswordEvent>(
      (event, emit) {
        emit(state.copyWith(oldPassword: event.oldPassword));
      },
    );
    on<NewPasswordEvent>(
      (event, emit) {
        emit(state.copyWith(newPassword: event.newPassword));
      },
    );
    on<ConfirmPasswordEvent>(
      (event, emit) {
        emit(state.copyWith(confirmPassword: event.confirmPassword));
      },
    );
    on<LoadUserStateEvent>(
      (event, emit) {
        emit(ChangePasswordState.load(event.user.toUserState()));
      },
    );
    on<SaveEvent>(
      (event, emit) async {
        emit(ChangePasswordLoadingState(
            name: state.name,
            surname: state.surname,
            email: state.email,
            password: state.password,
            birthYear: state.birthYear,
            gender: state.gender,
            oldPassword: state.oldPassword,
            newPassword: state.newPassword,
            confirmPassword: state.confirmPassword));

        final resource = await service.changePassword(event.user, state.oldPassword, state.newPassword);
        resource.onSuccess((data) {
          emit(ChangePasswordSuccessState(
              name: state.name,
              surname: state.surname,
              email: state.email,
              password: state.password,
              birthYear: state.birthYear,
              gender: state.gender,
              oldPassword: state.oldPassword,
              newPassword: state.newPassword,
              confirmPassword: state.confirmPassword));
        },);
        resource.onFailure( (fail) {
          emit(ChangePasswordFailState(
              fail: resource.error!,
              name: state.name,
              surname: state.surname,
              email: state.email,
              password: state.password,
              birthYear: state.birthYear,
              gender: state.gender,
              oldPassword: state.oldPassword,
              newPassword: state.newPassword,
              confirmPassword: state.confirmPassword));
        },);
      },
    );
  }
}
