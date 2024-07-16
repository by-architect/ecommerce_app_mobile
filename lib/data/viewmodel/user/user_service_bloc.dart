import 'package:ecommerce_app_mobile/common/helper/Log.dart';
import 'package:ecommerce_app_mobile/common/helper/resource.dart';
import 'package:ecommerce_app_mobile/data/provider/user_provider.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserServiceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  UserServiceBloc() : super(InitUserServiceState()) {
    on<AddUser>((event, emit) async {
      UserProvider userProvider = UserProvider();

      await userProvider.addUser(event.user, (resource) {
        Log.test("user_service_bloc status", message: resource.status.name);
        Log.test("user_service_bloc data", message: resource.data.toString());
        emit(UserServiceState(userData: resource));
      });
    });
  }
}
