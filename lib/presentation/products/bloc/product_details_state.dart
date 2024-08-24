import 'package:ecommerce_app_mobile/data/model/Reviews.dart';

import '../../../data/model/product.dart';
import '../../../data/model/product_details_item.dart';
import '../../../sddklibrary/helper/fail.dart';

class ProductDetailsState{
  final Reviews reviews;
  final List<Product> youMayAlsoLike;
  final List<ProductDetailsItem> productDetailsItems;

  ProductDetailsState( {required this.productDetailsItems,required this.reviews,required this.youMayAlsoLike});
}
class LoadProductState extends ProductDetailsState {
  LoadProductState( { required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}
class ProductDetailsInitState extends ProductDetailsState{
  ProductDetailsInitState():super(reviews: Reviews.empty(),youMayAlsoLike: [],productDetailsItems: []);
}

class ReviewsLoadingState extends ProductDetailsState{
  ReviewsLoadingState({required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});

}
class ReviewsSuccessState extends ProductDetailsState{
  ReviewsSuccessState({required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}
class ReviewsFailState extends ProductDetailsState{
  final Fail fail;

  ReviewsFailState({required this.fail,required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}

class YouMayAlsoLikeLoadingState extends ProductDetailsState{
  YouMayAlsoLikeLoadingState({required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}
class YouMayAlsoLikeSuccessState extends ProductDetailsState{
  YouMayAlsoLikeSuccessState({required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}
class YouMayAlsoLikeFailState extends ProductDetailsState{
  final Fail fail;
  YouMayAlsoLikeFailState({required this.fail,required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}

class ProductDetailsLoadingState extends ProductDetailsState{
  ProductDetailsLoadingState({required super.reviews, required super.youMayAlsoLike, required super.productDetailsItems});
}
class ProductDetailsSuccessState extends ProductDetailsState{
  ProductDetailsSuccessState({required super.productDetailsItems, required super.reviews, required super.youMayAlsoLike});
}
class ProductDetailsFailState extends ProductDetailsState{
  final Fail fail;
  ProductDetailsFailState({required this.fail ,required super.productDetailsItems, required super.reviews, required super.youMayAlsoLike});
}