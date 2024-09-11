import 'package:ecommerce_app_mobile/data/model/Reviews.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

import '../../../data/model/product.dart';
import '../../../data/model/product_details_item.dart';
import '../../../data/model/product_feature_with_selected_option.dart';
import '../../../sddklibrary/util/fail.dart';

class ProductDetailsState {
  final Reviews reviews;
  final List<Product> youMayAlsoLike;
  final List<ProductDetailsItem> productDetailsItems;
  final List<ProductFeatureWithSelectedOption> productFeaturesWithSelectedOption;
  final List<ProductFeatureOption?> selectedOptions;
  final List<ProductFeatureRowModel> optionMatrix;

  ProductDetailsState(
      {required this.productFeaturesWithSelectedOption,
      required this.optionMatrix,
      required this.selectedOptions,
      required this.productDetailsItems,
      required this.reviews,
      required this.youMayAlsoLike});

  ProductDetailsState copyWith(
      {Reviews? reviews,
      List<Product>? youMayAlsoLike,
      List<ProductDetailsItem>? productDetailsItems,
      List<ProductFeatureOption?>? selectedOptions,
        List<ProductFeatureRowModel>? optionMatrix,
      List<ProductFeatureWithSelectedOption>? productFeaturesWithSelectedOption}) {
    return ProductDetailsState(
        selectedOptions: selectedOptions ?? this.selectedOptions,
        productFeaturesWithSelectedOption:
            productFeaturesWithSelectedOption ?? this.productFeaturesWithSelectedOption,
        productDetailsItems: productDetailsItems ?? this.productDetailsItems,
        reviews: reviews ?? this.reviews,
        youMayAlsoLike: youMayAlsoLike ?? this.youMayAlsoLike, optionMatrix:optionMatrix ?? this.optionMatrix);
  }
}

class LoadProductState extends ProductDetailsState {
  LoadProductState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class ProductDetailsInitState extends ProductDetailsState {
  ProductDetailsInitState()
      : super(
            selectedOptions: [],
            productFeaturesWithSelectedOption: [],
            reviews: Reviews.empty(),
            youMayAlsoLike: [],
            optionMatrix: [],
            productDetailsItems: []);
}

class ReviewsLoadingState extends ProductDetailsState {
  ReviewsLoadingState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class ReviewsSuccessState extends ProductDetailsState {
  ReviewsSuccessState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class ReviewsFailState extends ProductDetailsState {
  final Fail fail;

  ReviewsFailState(
      {required this.fail,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class YouMayAlsoLikeLoadingState extends ProductDetailsState {
  YouMayAlsoLikeLoadingState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class YouMayAlsoLikeSuccessState extends ProductDetailsState {
  YouMayAlsoLikeSuccessState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class YouMayAlsoLikeFailState extends ProductDetailsState {
  final Fail fail;

  YouMayAlsoLikeFailState(
      {required this.fail,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class ProductDetailsLoadingState extends ProductDetailsState {
  ProductDetailsLoadingState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class ProductDetailsSuccessState extends ProductDetailsState {
  ProductDetailsSuccessState(
      {required super.productDetailsItems,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class ProductDetailsFailState extends ProductDetailsState {
  final Fail fail;

  ProductDetailsFailState(
      {required this.fail,
      required super.productDetailsItems,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.productFeaturesWithSelectedOption,
      required super.selectedOptions, required super.optionMatrix});
}

class SelectedProductFeaturesLoadingState extends ProductDetailsState {
  SelectedProductFeaturesLoadingState(
      {required super.productFeaturesWithSelectedOption,
      required super.selectedOptions,
      required super.productDetailsItems,
      required super.reviews,
      required super.youMayAlsoLike, required super.optionMatrix});
}
