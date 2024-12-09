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
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<GetInitItemsEvent>(
      (event, emit) async {
        emit(InitItemsLoadingState(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            appSettings: state.appSettings,
            userStatus: state.userStatus));

        ResourceStatus<AppSettings> appSettingsResource =
            await appSettingsService.getAppSettings();
        Resource<User> userResource = Resource.stable();
        Resource<Categories> categoriesResource = Resource.stable();
        Resource<AllProductFeatures> productFeaturesResource =
            Resource.stable();

        if (!appSettingsResource.isSuccess) {
          emit(InitItemsFailState(
              userStatus: state.userStatus,
              themeMode: state.themeMode,
              features: state.features,
              appSettings: state.appSettings,
              categories: state.categories,
              fail: appSettingsResource.error!));
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
            emit(InitItemsFailState(
                userStatus: state.userStatus,
                themeMode: state.themeMode,
                features: state.features,
                appSettings: state.appSettings,
                categories: state.categories,
                fail: userResource.error!));
            return;
          }
        }
        if (categoriesResource.status == Status.fail) {
          emit(InitItemsFailState(
              userStatus: state.userStatus,
              themeMode: state.themeMode,
              features: state.features,
              categories: state.categories,
              appSettings: state.appSettings,
              fail: categoriesResource.error!));
          return;
        }
        if (productFeaturesResource.status == Status.fail) {
          emit(InitItemsFailState(
              userStatus: state.userStatus,
              themeMode: state.themeMode,
              features: state.features,
              categories: state.categories,
              appSettings: state.appSettings,
              fail: productFeaturesResource.error!));
          return;
        }
        emit(InitItemsSuccessState(
            userStatus: userResource.stable
                ? state.userStatus
                : UserStatus(userResource.data),
            themeMode: state.themeMode,
            appSettings: appSettingsResource.data!,
            features: productFeaturesResource.stable
                ? state.features
                : productFeaturesResource.data!,
            categories: categoriesResource.stable
                ? state.categories
                : categoriesResource.data!));
      },
    );
    on<LogOutEvent>(
      (event, emit) async {
        final resource = await userService.signOut();
        if(resource.isSuccess) {
          emit(InitItemsSuccessState(
                themeMode: state.themeMode,
                features: state.features,
                categories: state.categories,
                userStatus: UserStatus(null),
                appSettings: state.appSettings));
        }
      },
    );

    on<UserSignedInEvent>(
      (event, emit) {
        emit(InitItemsSuccessState(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            appSettings: state.appSettings,
            userStatus: UserStatus(event.user)));
      },
    );
    on<UserIsVerifiedEvent>(
      (event, emit) {
        emit(InitItemsSuccessState(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            appSettings: state.appSettings,
            userStatus: UserStatus(event.user)));
      },
    );
  }
}
