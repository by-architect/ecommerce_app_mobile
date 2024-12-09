import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/user_status.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';
import '../../../sddklibrary/util/resource.dart';
import 'main_events.dart';
import 'main_states.dart';

class MainBlocs extends Bloc<MainEvents, MainStates> {
  MainBlocs() : super(InitMainStates()) {
    final productService = ProductServiceProvider();
    final userService = UserServiceImpl();
    final appSettingsService = FakeAppSettingsService();

    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(selectedPage: event.index));
    });

    on<ToggleThemeEvent>((event, emit) {
      emit( state.copyWith(themeMode: event.themeMode));
    });

    on<GetInitItemsEvent>(
      (event, emit) async {
        emit(InitItemsLoadingState(state: state));

        ResourceStatus<AppSettings> appSettingsResource =
            await appSettingsService.getAppSettings();
        Resource<User> userResource = Resource.stable();
        Resource<Categories> categoriesResource = Resource.stable();
        Resource<AllProductFeatures> productFeaturesResource =
            Resource.stable();

        if (!appSettingsResource.isSuccess) {
          emit(InitItemsFailState(
            state: state,
            fail: appSettingsResource.error!,
          ));
          return;
        }
        if (state.features.isEmpty) {
          productFeaturesResource = await productService.getProductFeatures();
        }
        if (state.categories.isEmpty) {
          categoriesResource = await productService.getCategoriesByLayer();
        }
        if (!state.userStatus.isAuthenticated) {
          userResource = await userService.getUser();
        }
        if (userResource.status == Status.fail) {
          if (userResource.error?.exception is! UserNotAuthenticatedException) {
            emit(InitItemsFailState(fail: userResource.error!, state: state));
            return;
          }
        }
        if (categoriesResource.status == Status.fail) {
          emit(InitItemsFailState(
              fail: categoriesResource.error!, state: state));
          return;
        }
        if (productFeaturesResource.status == Status.fail) {
          emit(InitItemsFailState(
              fail: productFeaturesResource.error!, state: state));
          return;
        }
        emit(InitItemsSuccessState(
            state: state.copyWith(
                userStatus: userResource.stable
                    ? state.userStatus
                    : UserStatus(userResource.data),
                themeMode: state.themeMode,
                appSettings: appSettingsResource.data!,
                productFeatures: productFeaturesResource.stable
                    ? state.features
                    : productFeaturesResource.data!,
                categories: categoriesResource.stable
                    ? state.categories
                    : categoriesResource.data!,
                selectedPage: state.selectedPage)));
      },
    );
    on<LogOutEvent>(
      (event, emit) async {
        final resource = await userService.signOut();
        if (resource.isSuccess) {
          emit(InitItemsSuccessState(
              state: state.copyWith(
            userStatus: UserStatus(null),
          )));
        }
      },
    );

    on<UserSignedInEvent>(
      (event, emit) {
        emit(InitItemsSuccessState(
            state: state.copyWith(
          userStatus: UserStatus(event.user),
        )));
      },
    );
    on<UserIsVerifiedEvent>(
      (event, emit) {
        emit(InitItemsSuccessState(
            state: state.copyWith(
          userStatus: UserStatus(event.user),
        )));
      },
    );
  }
}
