import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/Reviews.dart';


class RateBar extends StatelessWidget {
  const RateBar({
    super.key,
    required this.reviewStar,
    required this.value,
  });

  final ReviewStar reviewStar;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: reviewStar.starRating == 1 ? 0 : AppSizes.defaultPadding / 2),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              "${reviewStar.starRating} ${AppText.productDetailsPageStar}",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium!.color),
            ),
          ),
          const SizedBox(width: AppSizes.defaultPadding / 2),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.defaultBorderRadius),
              ),
              child: LinearProgressIndicator(
                minHeight: 6,
                color: AppColors.warningColor,
                backgroundColor: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.05),
                value: value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
