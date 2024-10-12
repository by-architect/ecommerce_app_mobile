import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/review.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/rate_bar.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/Reviews.dart';
import '../../../data/model/user.dart';

class ReviewUserCard extends StatelessWidget {
  const ReviewUserCard({super.key, required this.review, required this.user});

  final Review review;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.035),
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      radius: 28,
                      child:user.firebaseUser.photoURL !=null? NetworkImageWithLoader(
                        user.firebaseUser.photoURL! ,
                        radius: 100,
                      ): SvgPicture.asset(AppImages.profileIcon,width: 24,height: 24,colorFilter: ColorFilters.greyIconColorFilter(context),),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwHorizontalFields,),
                  Text("${user.name} ${user.surname}",style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
              Text("${review.dateTime.difference(DateTime.now()).abs().remainedTimeByType} ${AppText.ago}"),
              RatingBar.builder(
                initialRating: 3,
                itemSize: 14,
                itemPadding: const EdgeInsets.only(right: AppSizes.defaultPadding / 4),
                unratedColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
                glow: false,
                allowHalfRating: true,
                ignoreGestures: true,
                onRatingUpdate: (value) {},
                itemBuilder: (context, index) => SvgPicture.asset(AppImages.starFilledIcon),
              ),

            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceBtwHorizontalFields),
            child: Text(review.content,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),),
          ),
          const SizedBox(height: AppSizes.spaceBtwVerticalFieldsSmall,),
        ],
      ),
    );
  }
}
