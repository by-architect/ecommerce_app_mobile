import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/add_review_screen.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_list_tile.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/review_card.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/review_product_info_card.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/review_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/Reviews.dart';
import '../../../data/model/product.dart';

class ReviewsScreen extends StatelessWidget {
  final Reviews reviews;
  final Product product;

  const ReviewsScreen({super.key, required this.reviews,  required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPopBack(
        title: AppText.productDetailsPageReviews,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
              child: ReviewCard(reviews: reviews),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
          ),
          SliverToBoxAdapter(
            child: ProductListTile(
              isShowBottomBorder: true,
              svgSrc: AppImages.chatAddIcon,
              title: AppText.productDetailsPageAddReview,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReviewScreen(
                        title: product.name,
                        brand: product.brandName ?? "",
                        productId: product.productId, image: product.images.first,
                      ),
                    ));
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
              child: Row(
                children: [
                  Text(
                    AppText.productDetailsPageUserReviews,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: List.generate(
                reviews.count,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding,vertical: AppSizes.spaceBtwVerticalFieldsSmall),
                  child: ReviewUserCard(
                    review: FakeProductModels.review1,
                    user: FakeUserModels.someUser,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
