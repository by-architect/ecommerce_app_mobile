import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_events.dart';
import 'main_states.dart';

class MainBlocs extends Bloc<MainEvents, MainStates> {
  MainBlocs() : super(InitMainStates()) {
    final service = ProductServiceProvider();
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<GetInitItemsEvent>(
      (event, emit) async {
        emit(InitItemsLoadingState(
            themeMode: state.themeMode, features: state.features, categories: state.categories));
        final categoriesResource = await service.getCategoriesByLayer();
        final productFeaturesResource = await service.getProductFeatures();
        if (!categoriesResource.isSuccess) {
          emit(InitItemsFailState(
              themeMode: state.themeMode,
              features: state.features,
              categories: state.categories,
              fail: categoriesResource.error!));
          return;
        }
        if (!productFeaturesResource.isSuccess) {
          emit(InitItemsFailState(
              themeMode: state.themeMode,
              features: state.features,
              categories: state.categories,
              fail: productFeaturesResource.error!));
          return;
        }
        emit(InitItemsSuccessState(
            themeMode: state.themeMode,
            features: productFeaturesResource.data!,
            categories: categoriesResource.data!));
      },
    );
  }
}
