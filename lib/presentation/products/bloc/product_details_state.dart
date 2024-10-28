import 'package:ecommerce_app_mobile/data/model/Reviews.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

import '../../../data/model/product.dart';
import '../../../data/model/product_details_item.dart';
import '../../../data/model/product_feature_handler.dart';
import '../../../sddklibrary/util/fail.dart';

class ProductDetailsState {
  final Reviews reviews;
  final List<Product> youMayAlsoLike;
  final List<ProductDetailsItem> productDetailsItems;
  final List<ProductFeatureRowModel> optionMatrix;
  final int quantity;
  final SubProduct? selectedSubProduct;

  ProductDetailsState(
      {required this.optionMatrix,
      required this.quantity,
      required this.selectedSubProduct,
      required this.productDetailsItems,
      required this.reviews,
      required this.youMayAlsoLike});

  ProductDetailsState copyWith({
    Reviews? reviews,
    List<Product>? youMayAlsoLike,
    List<ProductDetailsItem>? productDetailsItems,
    List<ProductFeatureRowModel>? optionMatrix,
    int? quantity,
    SubProduct? selectedSubProduct,
  }) {
    return ProductDetailsState(
        selectedSubProduct: selectedSubProduct ?? this.selectedSubProduct,
        productDetailsItems: productDetailsItems ?? this.productDetailsItems,
        reviews: reviews ?? this.reviews,
        youMayAlsoLike: youMayAlsoLike ?? this.youMayAlsoLike,
        optionMatrix: optionMatrix ?? this.optionMatrix,
        quantity: quantity ?? this.quantity);
  }
}

class LoadProductState extends ProductDetailsState {
  LoadProductState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class ProductDetailsInitState extends ProductDetailsState {
  ProductDetailsInitState()
      : super(
            selectedSubProduct: null,
            reviews: Reviews.empty(),
            youMayAlsoLike: [],
            quantity: 1,
            optionMatrix: [],
            productDetailsItems: []);
}

class ReviewsLoadingState extends ProductDetailsState {
  ReviewsLoadingState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class ReviewsSuccessState extends ProductDetailsState {
  ReviewsSuccessState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class ReviewsFailState extends ProductDetailsState {
  final Fail fail;

  ReviewsFailState(
      {required this.fail,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class YouMayAlsoLikeLoadingState extends ProductDetailsState {
  YouMayAlsoLikeLoadingState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class YouMayAlsoLikeSuccessState extends ProductDetailsState {
  YouMayAlsoLikeSuccessState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class YouMayAlsoLikeFailState extends ProductDetailsState {
  final Fail fail;

  YouMayAlsoLikeFailState(
      {required this.fail,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class ProductDetailsLoadingState extends ProductDetailsState {
  ProductDetailsLoadingState(
      {required super.reviews,
      required super.youMayAlsoLike,
      required super.productDetailsItems,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class ProductDetailsSuccessState extends ProductDetailsState {
  ProductDetailsSuccessState(
      {required super.productDetailsItems,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class ProductDetailsFailState extends ProductDetailsState {
  final Fail fail;

  ProductDetailsFailState(
      {required this.fail,
      required super.productDetailsItems,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class SelectedProductFeaturesLoadingState extends ProductDetailsState {
  SelectedProductFeaturesLoadingState(
      {required super.productDetailsItems,
      required super.reviews,
      required super.youMayAlsoLike,
      required super.optionMatrix,
      required super.selectedSubProduct,
      required super.quantity});
}

class AddToCartLoadingState extends ProductDetailsState {
  final ProductDetailsState state;

  AddToCartLoadingState(this.state)
      : super(
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            optionMatrix: state.optionMatrix,
            selectedSubProduct: state.selectedSubProduct,
            quantity: state.quantity);
}

class AddToCartSuccessState extends ProductDetailsState {
  final ProductDetailsState state;

  AddToCartSuccessState(this.state)
      : super(
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            optionMatrix: state.optionMatrix,
            selectedSubProduct: state.selectedSubProduct,
            quantity: state.quantity);
}

class AddToCartFailState extends ProductDetailsState {
  final ProductDetailsState state;
  final Fail fail;

  AddToCartFailState(this.state, this.fail)
      : super(
            productDetailsItems: state.productDetailsItems,
            reviews: state.reviews,
            youMayAlsoLike: state.youMayAlsoLike,
            optionMatrix: state.optionMatrix,
            selectedSubProduct: state.selectedSubProduct,
            quantity: state.quantity);
}

class CartItemState {
  final Product product;
  final SubProduct subProduct;
  final int quantity;

  CartItemState({required this.product, required this.subProduct, required this.quantity});

  Map<String, dynamic> toMap(String uid) {
    return {"uid": uid, "sub_product_id": subProduct.id, "product_id": product.id, "quantity": quantity};
  }
}
