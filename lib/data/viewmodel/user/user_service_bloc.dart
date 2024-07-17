import 'package:ecommerce_app_mobile/data/fakerepository/fake_user_service.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/provider/user_provider.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/user_service.dart';

class UserServiceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  UserServiceBloc() : super(InitUserServiceState()) {
    on<AddUserEvent>((event, emit) async {
      UserService userService = UserServiceImpl();
      UserService fakeUserService = FakeUserService();

      emit(UserServiceState(userData: Resource.loading()));
      // await userService.addUser(event.user).then((resource) => emit(UserServiceState(userData: resource)));

     await fakeUserService.addUser(event.user).then((resource) => emit(UserServiceState(userData: resource)));


    });
  }
}
