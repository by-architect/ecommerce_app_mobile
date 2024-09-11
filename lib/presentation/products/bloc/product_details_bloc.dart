import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature_with_selected_option.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_feature_widget.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<GetReviewsEvent>(
          (event, emit) async {
        emit(ReviewsLoadingState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            productDetailsItems: state.productDetailsItems,
            selectedOptions: state.selectedOptions,
            optionMatrix: state.optionMatrix));
        final resource = await service.getReviews(event.productId);
        switch (resource.status) {
          case Status.success:
            emit(ReviewsSuccessState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                reviews: resource.data!,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.fail:
            emit(ReviewsFailState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.loading:
            emit(ReviewsLoadingState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.stable:
            break;
        }
      },
    );

    on<GetYouMayAlsoLikeEvent>(
          (event, emit) async {
        emit(YouMayAlsoLikeLoadingState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            productDetailsItems: state.productDetailsItems,
            selectedOptions: state.selectedOptions,
            optionMatrix: state.optionMatrix));
        final resource = await service.getYouMayAlsoLike(event.categoryId);
        switch (resource.status) {
          case Status.success:
            emit(YouMayAlsoLikeSuccessState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                reviews: state.reviews,
                youMayAlsoLike: resource.data!,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.fail:
            emit(YouMayAlsoLikeFailState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.loading:
            emit(YouMayAlsoLikeLoadingState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.stable:
            break;
        }
      },
    );
    on<CleanStateEvent>(
          (event, emit) {
        emit(ProductDetailsInitState());
      },
    );

    on<GetProductDetailsEvent>(
          (event, emit) async {
        emit(ProductDetailsLoadingState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            productDetailsItems: state.productDetailsItems,
            selectedOptions: state.selectedOptions,
            optionMatrix: state.optionMatrix));
        final resource = await service.getProductDetails(event.productId);
        switch (resource.status) {
          case Status.success:
            emit(ProductDetailsSuccessState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: resource.data!,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.fail:
            emit(ProductDetailsFailState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.loading:
            emit(ProductDetailsLoadingState(
                productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                selectedOptions: state.selectedOptions,
                optionMatrix: state.optionMatrix));
            break;
          case Status.stable:
            break;
        }
      },
    );
    on<GetProductFeaturesEvent>(
          (event, emit) {
        emit(SelectedProductFeaturesLoadingState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            selectedOptions: state.selectedOptions,
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            optionMatrix: state.optionMatrix));

        final productFeatureOptionHandler = ProductFeatureOptionHandler();

        final optionMatrix = productFeatureOptionHandler.getOptionMatrix(
            event.productFeaturesOfSelectedProduct, event.subProducts, event.idealSubProduct);

       final selectedOptionMatrix =  productFeatureOptionHandler.selectOptionsOfSubProduct(selectedSubProduct: event.idealSubProduct,
            optionMatrix: optionMatrix,
            subProducts: event.subProducts);

/*
        final List<ProductFeatureOption?> selectedOptions = [];

        ProductFeatureOption? currentOption;
        for (int columnIndex = 0; columnIndex < event.options.length; columnIndex++) {
          currentOption = null;
          for (int rowIndex = 0; rowIndex < event.options[columnIndex].length; rowIndex++) {
            for (var subProductOptionId in (event.selectedSubProduct.productFeatureOptionIds)) {
              if (subProductOptionId == event.options[columnIndex][rowIndex].id) {
                currentOption = event.options[columnIndex][rowIndex];
                break;
              }
            }
          }
          selectedOptions.add(currentOption);
        }
*/

/*
        Log.test(title: "product details bloc selectedProductFeatures", data: event.options);
        Log.test(title: "product details bloc selected options", data: selectedOptions);
*/
        emit(state.copyWith(optionMatrix: selectedOptionMatrix));
      },
    );
    on<SelectProductFeatureOptionEvent>(
          (event, emit) {
        emit(SelectedProductFeaturesLoadingState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            selectedOptions: state.selectedOptions,
            productDetailsItems: state.productDetailsItems,
            optionMatrix: state.optionMatrix,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike));

        final optionMatrix = ProductFeatureOptionHandler().selectOptionAndRemoveOthers(
          optionMatrix: state.optionMatrix,
          selectedOption: event.selectedOption,
          subProducts: event.subProducts,
        );
        emit(ProductDetailsState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            optionMatrix: optionMatrix,
            selectedOptions: state.selectedOptions,
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike));
/*
        emit(state.copyWith(
            optionMatrix: ProductFeatureOptionHandler().selectOption(
                state.optionMatrix, event.selectedOption, event.columnIndex, event.rowIndex)));
*/

/*        emit(SelectedProductFeaturesLoadingState(
            productFeaturesWithSelectedOption: state.productFeaturesWithSelectedOption,
            selectedOptions: state.selectedOptions,
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike));


        final selectedOptions = state.selectedOptions;
        ProductFeatureOption? currentOption;
        for (int columnIndex = 0; columnIndex < event.options.length; columnIndex++) {
          currentOption = null;
          for (int rowIndex = 0; rowIndex < event.options[columnIndex].length; rowIndex++) {
            for (var subProductOptionId in (event.selectedSubProduct.productFeatureOptionIds)) {
              if (subProductOptionId == event.options[columnIndex][rowIndex].id) {
                currentOption = event.options[columnIndex][rowIndex];
                break;
              }
            }
          }
          selectedOptions.add(currentOption);
        }
        emit(state.copyWith(selectedOptions: selectedOptions));

*/ /*        List<ProductFeatureWithSelectedOption> productFeaturesWithSelectedOption =
            state.productFeaturesWithSelectedOption;
        productFeaturesWithSelectedOption.removeWhere(
          (feature) =>
              feature.productFeature.id == event.productFeatureWithSelectedOption.productFeature.id,
        );
        productFeaturesWithSelectedOption.add(event.productFeatureWithSelectedOption);
        for (var subProduct in state.selectedOptions.selectedOptions) {
          if (subProduct.productFeatureOptionIds
              .contains(event.productFeatureWithSelectedOption.selectedOption.id)) {

          }
        }
        emit(state.copyWith(productFeaturesWithSelectedOption: productFeaturesWithSelectedOption));*/
      },
    );
/*
    on<NextProductNodeEvent>((event, emit) {
      List<Product> productNode = state.productNode;
     productNode.add(event.product) ;
     emit(LoadProductState(productNode: productNode, reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike));
    },);
    on<PreviousProductNodeEvent>((event, emit) {
      List<Product> productNode = state.productNode;
      productNode.removeLast();
      emit(LoadProductState(productNode: productNode, reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike));
    },);
*/
  }
}
