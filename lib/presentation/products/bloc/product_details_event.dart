import 'package:ecommerce_app_mobile/data/model/tag.dart';

import '../../../data/model/product.dart';

class ProductDetailsEvent{}

class CleanStateEvent extends ProductDetailsEvent{}
class NextProductNodeEvent extends ProductDetailsEvent{
  final Product product;

  NextProductNodeEvent(this.product);
}
class PreviousProductNodeEvent extends ProductDetailsEvent{}
class GetReviewsEvent extends ProductDetailsEvent{
final String productId;
  GetReviewsEvent(this.productId);
}
class GetYouMayAlsoLikeEvent extends ProductDetailsEvent{
  final String categoryId;

  GetYouMayAlsoLikeEvent(this.categoryId);
}
class GetProductDetailsEvent extends ProductDetailsEvent{
  final String productId;

  GetProductDetailsEvent(this.productId);
}