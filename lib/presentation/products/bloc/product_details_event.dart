import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/tag.dart';

import '../../../data/model/product.dart';
import '../../../data/model/product_feature_handler.dart';

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
  final ProductFeatureHandler productFeatureHandler;

  GetProductFeaturesEvent( this.productFeatureHandler);
}

class SelectProductFeatureOptionEvent extends ProductDetailsEvent {
  final ProductFeatureOptionModel selectedOption;
  final ProductFeatureHandler productFeatureHandler;

  SelectProductFeatureOptionEvent( {
    required this.productFeatureHandler,
    required this.selectedOption,
  });
}
