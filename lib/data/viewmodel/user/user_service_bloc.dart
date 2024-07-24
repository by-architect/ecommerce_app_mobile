import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/user_service.dart';

class UserServiceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  UserServiceBloc() : super(AddUserInitState()) {
    UserService userService = UserServiceImpl();

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
      emit(SendVerificationEmailLoadingState());

      final resource = await userService.sendVerificationEmail(event.user);
      switch (resource.status) {
        case Status.success:
          emit(SendVerificationEmailSuccessState(resource.data!));
        case Status.fail:
          emit(SendVerificationEmailFailState(resource.error!));
        case Status.loading:
          emit(SendVerificationEmailLoadingState());
        case Status.stable:
          emit(SendVerificationEmailInitState());
      }
    });

    on<IsUserVerifiedEvent>((event, emit) async {
      final resource = await userService.isEmailVerified();

      switch (resource.status) {
        case Status.success:
          if (resource.data!.emailVerified) {
            emit(EmailVerifiedState(resource.data!));
          } else {
            emit(EmailNotVerifiedState());
          }
        case Status.fail:
          emit(EmailVerificationFailState(resource.error!));
        case Status.loading:
        case Status.stable:
      }
    });

    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoadingState());
      final userAuthenticated = userService.isUserAuthenticated();
      if (userAuthenticated) {
        final resource = await userService.getUser();
        switch (resource.status) {
          case Status.success:
            emit(GetUserSuccessState(resource.data!));
          case Status.fail:
            emit(GetUserFailState(resource.error!));
          case Status.loading:
            emit(GetUserLoadingState());
          case Status.stable:
        }
      }else{
        emit(GetUserFailState(DefaultError(userMessage: AppText.errorAuthenticate)));
      }
    });
  }
}
