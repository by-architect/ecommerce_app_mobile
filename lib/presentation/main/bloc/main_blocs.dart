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
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<GetInitItemsEvent>(
          (event, emit) async {
        emit(InitItemsLoadingState(
            themeMode: state.themeMode,
            features: state.features,
            categories: state.categories,
            userStatus: state.userStatus));
        Resource<User> userResource = Resource.stable();
        Resource<Categories> categoriesResource = Resource.stable();
        Resource<AllProductFeatures> productFeaturesResource = Resource.stable();
        if (state.features.isEmpty) productFeaturesResource = await productService.getProductFeatures();
        if (state.categories.isEmpty) {
          categoriesResource = await productService.getCategoriesByLayer();
        }
        if (!state.userStatus.isAuthenticated) userResource = await userService.getUser();
        if (userResource.status == Status.fail) {
          if (userResource.error?.exception is! UserNotAuthenticatedException) {
            emit(InitItemsFailState(
                userStatus: state.userStatus,
                themeMode: state.themeMode,
                features: state.features,
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
              fail: categoriesResource.error!));
          return;
        }
        if (productFeaturesResource.status == Status.fail) {
          emit(InitItemsFailState(
              userStatus: state.userStatus,
              themeMode: state.themeMode,
              features: state.features,
              categories: state.categories,
              fail: productFeaturesResource.error!));
          return;
        }
        emit(InitItemsSuccessState(
            userStatus: userResource.stable ? state.userStatus : UserStatus(userResource.data),
            themeMode: state.themeMode,
            features: productFeaturesResource.stable ? state.features : productFeaturesResource.data!,
            categories: categoriesResource.stable ? state.categories : categoriesResource.data!));
      },
    );
    on<LogOutEvent>(
          (event, emit) async {
        final resource = await userService.signOut();
        switch (resource.status) {
          case Status.success:
            emit(InitItemsSuccessState(
                themeMode: state.themeMode,
                features: state.features,
                categories: state.categories,
                userStatus: UserStatus(null)));
            break;
          case Status.fail:
            break;
          case Status.loading:
          // TODO: Handle this case.
            break;
          case Status.stable:
          // TODO: Handle this case.
            break;
        }
      },
    );
    on<UserIsVerifiedEvent>((event, emit) {
      emit(InitItemsSuccessState(themeMode: state.themeMode,
          features: state.features,
          categories: state.categories,
          userStatus: UserStatus(event.user)));
    },);

  }
}
