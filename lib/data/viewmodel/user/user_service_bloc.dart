import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/user_service.dart';

class UserServiceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  UserServiceBloc() : super(AddUserInitState()) {
    UserService userService = UserServiceImpl();
    // UserService fakeUserService = FakeUserService();

    on<AddUserEvent>((event, emit) async {
      emit(AddUserLoadingState());

      final resource = await userService.addUser(event.user);

      switch (resource.status) {
        case Status.success:
          emit(AddUserSuccessState(resource.data!));
        case Status.fail:
          emit(AddUserFailState(resource.error!));
        case Status.loading:
          emit(AddUserLoadingState());
        case Status.stable:
          emit(AddUserInitState());
      }
    });

    on<SendVerificationCodeEvent>((event, emit) async {
      emit(SendVerificationCodeLoadingState());

      final resource = await userService.sendVerificationEmail(event.user);
      switch (resource.status) {
        case Status.success:
          emit(SendVerificationCodeSuccessState());
        case Status.fail:
          emit(SendVerificationCodeFailState(resource.error!));
        case Status.loading:
          emit(SendVerificationCodeLoadingState());
        case Status.stable:
          emit(SendVerificationCodeInitState());
      }
    });

    on<IsUserVerifiedEvent>((event, emit) async {
      final resource = await userService.isEmailVerified();

      switch (resource.status) {
        case Status.success:
          if (resource.data!) {
            emit(EmailVerifiedState());
          } else {
            emit(EmailNotVerifiedState());
          }
        case Status.fail:
          emit(EmailVerificationFailState(resource.error!));
        case Status.loading:
        case Status.stable:
      }
    });
  }
}
