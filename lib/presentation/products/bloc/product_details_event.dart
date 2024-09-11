import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature_with_selected_option.dart';
import 'package:ecommerce_app_mobile/data/model/tag.dart';

import '../../../data/model/product.dart';

class ProductDetailsEvent {}

class CleanStateEvent extends ProductDetailsEvent {}

class GetReviewsEvent extends ProductDetailsEvent {
  final String productId;

  GetReviewsEvent(this.productId);
}

class GetYouMayAlsoLikeEvent extends ProductDetailsEvent {
  final String categoryId;

  GetYouMayAlsoLikeEvent(this.categoryId);
}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  GetProductDetailsEvent(this.productId);
}

class GetProductFeaturesEvent extends ProductDetailsEvent {
  final List<ProductFeature> productFeaturesOfSelectedProduct;
  final SubProducts subProducts;
  final SubProduct idealSubProduct;

  GetProductFeaturesEvent(this.productFeaturesOfSelectedProduct, this.subProducts, this.idealSubProduct);
}

class SelectProductFeatureOptionEvent extends ProductDetailsEvent {
  final ProductFeatureOptionModel selectedOption;
  final SubProducts subProducts;
  final int columnIndex;
  final int rowIndex;

  SelectProductFeatureOptionEvent({
    required this.selectedOption,
    required this.columnIndex,
    required this.rowIndex,
    required this.subProducts,
  });
}
