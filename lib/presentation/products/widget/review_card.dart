import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/rate_bar.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../data/model/Reviews.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.reviews,
  });

  final Reviews reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.defaultPadding),
      width: double.infinity,
      decoration: AppStyles.borderlessGreyBoxDecoration(context.isDarkMode),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "${reviews.ratingString} ",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "/5",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Text("${AppText.productDetailsPageBasedOn} ${reviews.count} ${AppText.productDetailsPageReviews}"),
                const SizedBox(height: AppSizes.defaultPadding),
                RatingBar.builder(
                  initialRating: reviews.rating,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.only(right: AppSizes.defaultPadding / 4),
                  unratedColor: context.isDarkMode ? AppColors.blackColor80 : AppColors.whiteColor90,
                  glow: false,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  onRatingUpdate: (value) {},
                  itemBuilder: (context, index) => SvgPicture.asset(AppImages.starFilledIcon),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.defaultPadding),
          Expanded(
            child: Column(
              children: ReviewStar.values.map(
                (reviewStar) {
                  return RateBar(reviewStar: reviewStar, value: reviews.getStarCountPercent(reviewStar));
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
