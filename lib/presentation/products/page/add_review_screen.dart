import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/review.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/data/provider/user_provider.dart';
import 'package:ecommerce_app_mobile/data/usecase/review_validation.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/review_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/review_product_info_card.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/validation_result.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../data/model/Reviews.dart';
import '../../../data/model/user.dart';

class AddReviewScreen extends StatefulWidget {
  final String productId;
  final String image;
  final String title;
  final String brand;

  const AddReviewScreen({
    super.key,
    required this.productId,
    required this.image,
    required this.title,
    required this.brand,
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  @override
  Widget build(BuildContext context) {
    ReviewState reviewState = ReviewState();
    ReviewStar? starState;
    bool loading = false;
    return Scaffold(
      appBar: const AppBarPopBack(
        title: AppText.productDetailsPageAddReview,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReviewProductInfoCard(image: widget.image, title: widget.title, brand: widget.brand),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Divider(),
                    const Text(AppText.productDetailsPageOverallRating),
                    RatingBar.builder(
                      initialRating: 0,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.only(right: AppSizes.defaultPadding / 4),
                      unratedColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
                      glow: false,
                      allowHalfRating: false,
                      ignoreGestures: false,
                      onRatingUpdate: (value) {
                        Log.test(title: "star",data: value.toInt().toString());
                        reviewState = reviewState.copyWith(star: ReviewStar.getByInt(value.toInt()));
                      },
                      itemBuilder: (context, index) => SvgPicture.asset(AppImages.starFilledIcon),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              Text(
                AppText.productDetailsPageSetATitle,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldDefault(
                maxLength: 100,
                onChanged: (value) {
                    reviewState = reviewState.copyWith(title: value);
                },
                hint: AppText.productDetailsPageSummarizeReview,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFieldsSmall,
              ),
              Text(
                AppText.productDetailsPageWhatDidYouLike,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldDefault(
                maxLines: 5,
                maxLength: 300,
                onChanged: (value) {
                  reviewState = reviewState.copyWith(content: value);
                },
                hint: AppText.productDetailsPageWhatShouldShoppersKnow,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFieldsLarge,
              ),
              ButtonPrimary(
                text: AppText.productDetailsPageSubmitReview,
                onTap: () {
                  final dialog = DialogUtil(context);
                  ValidationResult validationResult = ReviewValidation(reviewState).validate();
                  if (!validationResult.success) {
                    dialog.toast(validationResult.message);
                    return;
                  }
                  final review = reviewState.copyWith(dateTime: DateTime.now());

                  ProductServiceProvider serviceProvider = ProductServiceProvider();
                  serviceProvider.addReviewAsResource(
                    review,
                    (resource) {
                      switch (resource.status) {
                        case Status.success:
                          setState(() {
                            dialog.toast(AppText.productDetailsPageReviewSubmitted);
                            loading = false;
                          });
                          Navigator.of(context).pop();
                          break;
                        case Status.fail:
                          setState(() {
                            dialog.toast(resource.error!.userMessage);
                            loading = false;
                          });
                          break;
                        case Status.loading:
                          setState(() {
                            loading = true;
                          });
                          break;
                        case Status.stable:
                          break;
                      }
                    },
                  );
                },
                loading: loading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
