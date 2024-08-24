import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_card_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/product_details_bottom_sheet.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/product_returns_screen.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/reviews_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../common/widgets/product_card.dart';
import '../widget/button_cart_buy.dart';
import '../widget/custom_modal_bottom_sheet.dart';
import '../widget/product_buy_now_screen.dart';
import '../widget/product_images.dart';
import '../widget/product_info.dart';
import '../widget/product_list_tile.dart';
import '../widget/review_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    this.previousProduct,
    required this.product,
  });

  final Product? previousProduct;
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    BlocProvider.of<ProductDetailsBloc>(context).add(GetReviewsEvent(widget.product.productId));
    BlocProvider.of<ProductDetailsBloc>(context).add(GetProductDetailsEvent(widget.product.productId));
    BlocProvider.of<ProductDetailsBloc>(context).add(GetYouMayAlsoLikeEvent(widget.product.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (BuildContext context, ProductDetailsState state) => PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (widget.previousProduct != null) {
            BlocProvider.of<ProductDetailsBloc>(context).add(GetReviewsEvent(widget.previousProduct!.productId));
            BlocProvider.of<ProductDetailsBloc>(context).add(GetYouMayAlsoLikeEvent(widget.previousProduct!.categoryId));
            BlocProvider.of<ProductDetailsBloc>(context).add(GetProductDetailsEvent(widget.previousProduct!.productId));
          }
        },
        child: Scaffold(
          bottomNavigationBar: widget.product.availableInStock
              ? ButtonCartBuy(
                  price: 140,
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: ProductBuyNowScreen(
                        product: widget.product,
                      ),
                    );
                  },
                )
              : const SizedBox.shrink(),

          /// If profuct is not available then show [NotifyMeCard]

          /*
          NotifyMeCard(
            isNotify: false,
            onChanged: (value) {},
          ),
        */
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  floating: true,
                ),
                ProductImages(
                  images: widget.product.images,
                ),
                ProductInfo(
                  brand: widget.product.brandName ?? "",
                  title: widget.product.name,
                  isAvailable: widget.product.availableInStock,
                  description: widget.product.info,
                  rating: state.reviews.ratingString,
                  numOfReviews: state.reviews.count,
                ),
                ProductListTile(
                  svgSrc: AppImages.productIcon,
                  title: AppText.productDetailsPageDetails,
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      //todo: handle this
                      child: ProductDetailsBottomSheet(
                        items: state.productDetailsItems,
                      ),
                    );
                  },
                ),
                /*
                ProductListTile(
                  svgSrc: "assets/icons/Delivery.svg",
                  title: "Shipping Information",
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: const Placeholder(),
                    );
                  },
                ),
        */
                ProductListTile(
                  svgSrc: AppImages.returnIcon,
                  title: AppText.productDetailsPageReturns,
                  isShowBottomBorder: true,
                  press: () {
                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: ProductReturnsScreen(
                        returnText: widget.product.returns,
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.defaultPadding),
                    child: ReviewCard(
                      reviews: state.reviews,
                    ),
                  ),
                ),
                ProductListTile(
                  svgSrc: AppImages.chatIcon,
                  title: AppText.productDetailsPageReviews,
                  isShowBottomBorder: true,
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReviewsScreen(reviews: state.reviews, product: widget.product,),
                    ));
                  },
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSizes.defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      AppText.productDetailsPageYouMayAlsoLike,
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state is YouMayAlsoLikeLoadingState ? 10 : state.youMayAlsoLike.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: AppSizes.defaultPadding, right: index == 4 ? AppSizes.defaultPadding : 0),
                        child: state is YouMayAlsoLikeLoadingState
                            ? const ProductCardSkeleton()
                            : ProductCard(
                                product: state.youMayAlsoLike[index],
                                previousProduct: widget.product,
                              ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.defaultPadding),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
