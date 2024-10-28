import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/user_service.dart';

class UserServiceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  UserServiceBloc() : super(AddUserInitState()) {
    UserService userService = UserServiceImpl();

    on<AddUserEvent>((event, emit) async {
/*      emit(AddUserLoadingState());

      final resource = await userService.addUser(event.user);

      switch (resource.status) {
        case Status.success:
          emit(AddUserSuccessState(resource.data!));
          break;
        case Status.fail:
          emit(AddUserFailState(resource.error!));
          break;
        case Status.loading:
          emit(AddUserLoadingState());
          break;
        case Status.stable:
          emit(AddUserInitState());
          break;
      }*/
    });

    on<SendVerificationEmailEvent>((event, emit) async {
      emit(SendVerificationEmailLoadingState());

      final resource = await userService.sendVerificationEmail(event.user);
      switch (resource.status) {
        case Status.success:
          emit(SendVerificationEmailSuccessState(resource.data!));
          break;
        case Status.fail:
          emit(SendVerificationEmailFailState(resource.error!));
          break;
        case Status.loading:
          emit(SendVerificationEmailLoadingState());
          break;
        case Status.stable:
          emit(SendVerificationEmailInitState());
          break;
      }
    });

    on<IsUserVerifiedEvent>((event, emit) async {
      final resource = await userService.isEmailVerified();

      switch (resource.status) {
        case Status.success:
          if (resource.data!.firebaseUser.emailVerified) {
            emit(EmailVerifiedState(resource.data!));
          } else {
            emit(EmailNotVerifiedState());
          }
          break;
        case Status.fail:
          emit(EmailVerificationFailState(resource.error!));
          break;
        case Status.loading:
          break;
        case Status.stable:
        break;
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
            break;
          case Status.fail:
            emit(GetUserFailState(resource.error!));
            break;
          case Status.loading:
            emit(GetUserLoadingState());
            break;
          case Status.stable:
            break;
        }
      }else{
        emit(GetUserFailState(Fail(userMessage: AppText.errorAuthenticate.capitalizeFirstWord.get)));
      }
    });
    on<LoginEvent>((event,emit) async {
/*     emit(LoginUserLoadingState());
     final userLoginResource = await userService.signIn(event.user);
     switch(userLoginResource.status){

       case Status.success:
         emit(LoginUserSuccessState(userLoginResource.data!));
         break;
       case Status.fail:
         emit(LoginUserFailState(userLoginResource.error!));
         break;
       case Status.loading:
         emit(LoginUserLoadingState());
         break;
       case Status.stable:
         break;
     }*/
    });
  }
}
