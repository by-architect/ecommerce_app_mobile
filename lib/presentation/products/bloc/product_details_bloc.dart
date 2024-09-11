import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<GetReviewsEvent>(
      (event, emit) async {
        emit(ReviewsLoadingState(
          reviews: state.reviews,
          youMayAlsoLike: state.youMayAlsoLike,
          productDetailsItems: state.productDetailsItems,
          optionMatrix: state.optionMatrix,
          selectedSubProduct: state.selectedSubProduct,
        ));
        final resource = await service.getReviews(event.productId);
        switch (resource.status) {
          case Status.success:
            emit(ReviewsSuccessState(
                selectedSubProduct: state.selectedSubProduct,
                reviews: resource.data!,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                optionMatrix: state.optionMatrix));
            break;
          case Status.fail:
            emit(ReviewsFailState(
                selectedSubProduct: state.selectedSubProduct,
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                optionMatrix: state.optionMatrix));
            break;
          case Status.loading:
            emit(ReviewsLoadingState(
                selectedSubProduct: state.selectedSubProduct,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
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
            selectedSubProduct: state.selectedSubProduct,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            productDetailsItems: state.productDetailsItems,
            optionMatrix: state.optionMatrix));
        final resource = await service.getYouMayAlsoLike(event.categoryId);
        switch (resource.status) {
          case Status.success:
            emit(YouMayAlsoLikeSuccessState(
                selectedSubProduct: state.selectedSubProduct,
                reviews: state.reviews,
                youMayAlsoLike: resource.data!,
                productDetailsItems: state.productDetailsItems,
                optionMatrix: state.optionMatrix));
            break;
          case Status.fail:
            emit(YouMayAlsoLikeFailState(
                selectedSubProduct: state.selectedSubProduct,
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                optionMatrix: state.optionMatrix));
            break;
          case Status.loading:
            emit(YouMayAlsoLikeLoadingState(
                selectedSubProduct: state.selectedSubProduct,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
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
            selectedSubProduct: state.selectedSubProduct,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            productDetailsItems: state.productDetailsItems,
            optionMatrix: state.optionMatrix));
        final resource = await service.getProductDetails(event.productId);
        switch (resource.status) {
          case Status.success:
            emit(ProductDetailsSuccessState(
                selectedSubProduct: state.selectedSubProduct,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: resource.data!,
                optionMatrix: state.optionMatrix));
            break;
          case Status.fail:
            emit(ProductDetailsFailState(
                selectedSubProduct: state.selectedSubProduct,
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
                optionMatrix: state.optionMatrix));
            break;
          case Status.loading:
            emit(ProductDetailsLoadingState(
                selectedSubProduct: state.selectedSubProduct,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems,
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
            selectedSubProduct: state.selectedSubProduct,
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            optionMatrix: state.optionMatrix));

        final optionMatrix = event.productFeatureHandler.createOptionMatrix();

        final selectedOptionMatrix = event.productFeatureHandler.selectOptionsOfSubProduct(
            optionMatrix: optionMatrix, selectedSubProduct: event.productFeatureHandler.idealSubProduct);

        emit(state.copyWith(optionMatrix: selectedOptionMatrix,selectedSubProduct: event.productFeatureHandler.idealSubProduct));
      },
    );
    on<SelectProductFeatureOptionEvent>(
      (event, emit) {
        emit(SelectedProductFeaturesLoadingState(
            productDetailsItems: state.productDetailsItems,
            optionMatrix: state.optionMatrix,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            selectedSubProduct: state.selectedSubProduct));

        final optionMatrixWithSubProduct = event.productFeatureHandler.selectOptionAndRemoveOthers(
          optionMatrix: state.optionMatrix,
          selectedOption: event.selectedOption,
        );
        emit(ProductDetailsState(
            selectedSubProduct: optionMatrixWithSubProduct.subProduct,
            optionMatrix: optionMatrixWithSubProduct.optionMatrix,
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
