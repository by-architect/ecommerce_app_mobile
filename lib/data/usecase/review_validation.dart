import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/review_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/validation_result.dart';

import '../model/review.dart';

class ReviewValidation {
  final ReviewState review;

  ReviewValidation(this.review);

  ValidationResult validate() {
    if(review.star == null){
      return ValidationResult(false,message: AppText.errorStarMustBeSelected);
    }
    if(review.title == null || review.title!.isEmpty){
      return ValidationResult(false,message: AppText.errorTitleCanNotBeEmpty);
    }
    if(review.content == null || review.content!.isEmpty){
      return ValidationResult(false,message: AppText.errorContentCanNotBeEmpty);
    }
    return ValidationResult(true);
  }
}
