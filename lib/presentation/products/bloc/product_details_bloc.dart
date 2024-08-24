import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<GetReviewsEvent>(
      (event, emit) async {
        emit(ReviewsLoadingState(
            reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
        final resource = await service.getReviews(event.productId);
        switch (resource.status) {
          case Status.success:
            emit(ReviewsSuccessState(
                reviews: resource.data!, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
            break;
          case Status.fail:
            emit(ReviewsFailState(
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems));
            break;
          case Status.loading:
            emit(ReviewsLoadingState(
                reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
            break;
          case Status.stable:
            break;
        }
      },
    );

    on<GetYouMayAlsoLikeEvent>(
      (event, emit) async {
        emit(YouMayAlsoLikeLoadingState(
            reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
        final resource = await service.getYouMayAlsoLike(event.categoryId);
        switch (resource.status) {
          case Status.success:
            emit(YouMayAlsoLikeSuccessState(
                reviews: state.reviews, youMayAlsoLike: resource.data!, productDetailsItems: state.productDetailsItems));
            break;
          case Status.fail:
            emit(YouMayAlsoLikeFailState(
                fail: resource.error!,
                reviews: state.reviews,
                youMayAlsoLike: state.youMayAlsoLike,
                productDetailsItems: state.productDetailsItems));
            break;
          case Status.loading:
            emit(YouMayAlsoLikeLoadingState(
                reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
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
              reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
          final resource = await service.getProductDetails(event.productId);
          switch (resource.status) {
            case Status.success:
              emit(ProductDetailsSuccessState(
                  reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: resource.data!));
              break;
            case Status.fail:
              emit(ProductDetailsFailState(
                  fail: resource.error!,
                  reviews: state.reviews,
                  youMayAlsoLike: state.youMayAlsoLike,
                  productDetailsItems: state.productDetailsItems));
              break;
            case Status.loading:
              emit(ProductDetailsLoadingState(
                  reviews: state.reviews, youMayAlsoLike: state.youMayAlsoLike, productDetailsItems: state.productDetailsItems));
              break;
            case Status.stable:
              break;
          }
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
