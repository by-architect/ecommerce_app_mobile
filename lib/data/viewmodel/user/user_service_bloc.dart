import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/user_service.dart';

class UserServiceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  UserServiceBloc() : super(AddUserInitState()) {
    UserService userService = UserServiceImpl();
    UserService fakeUserService = FakeUserService();

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

      // await _fakeUserService.addUser(event.user).then((resource) => emit(UserServiceState(userData: resource)));
    });

    on<SendVerificationCodeEvent>((event, emit) async {
      emit(SendVerificationCodeLoadingState());

      final resource = await userService.sendEmailVerificationCode(event.email);
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
  }
}
