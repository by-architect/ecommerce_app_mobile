import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_event.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitState()) {
    final service = UserServiceImpl();
    on<NameEvent>(
      (event, emit) {
        emit(state.copyWith(name: event.name));
      },
    );
    on<SurnameEvent>(
      (event, emit) {
        emit(state.copyWith(surname: event.surname));
      },
    );
    on<GenderEvent>(
      (event, emit) {
        emit(state.copyWith(gender: event.gender));
      },
    );
    on<BirthYearEvent>(
      (event, emit) {
        emit(state.copyWith(birthYear: event.birthYear));
      },
    );
    on<LoadUserEvent>(
      (event, emit) {
        emit(EditProfileState(
            name: event.user.name,
            surname: event.user.surname,
            birthYear: event.user.birthYear.toString(),
            gender: event.user.gender));
      },
    );
    on<UpdateEvent>(
      (event, emit) async {
        emit(EditProfileLoadingState(
            name: state.name, surname: state.surname, birthYear: state.birthYear, gender: state.gender));
        final resource = await service.editUserSettings(event.user, state);
        switch (resource.status) {
          case Status.success:
            emit(EditProfileSuccessState(
                user: resource.data!,
                name: state.name,
                surname: state.surname,
                birthYear: state.birthYear,
                gender: state.gender));
            break;
          case Status.fail:
            emit(EditProfileFailState(
                fail: resource.error!,
                name: state.name,
                surname: state.surname,
                birthYear: state.birthYear,
                gender: state.gender));
            break;
          case Status.loading:
            emit(EditProfileLoadingState(
                name: state.name,
                surname: state.surname,
                birthYear: state.birthYear,
                gender: state.gender));
            break;
          case Status.stable:
            break;
        }
      },
    );
  }
}
