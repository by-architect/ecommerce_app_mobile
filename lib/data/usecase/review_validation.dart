import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/review_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/validation_result.dart';

import '../model/review.dart';

class ReviewValidation {
  final ReviewState review;

  ReviewValidation(this.review);

  ValidationResult validate() {
    if(review.star == null){
      return ValidationResult(false,message: AppText.errorStarMustBeSelected.capitalizeFirstWord.get);
    }
    if(review.title == null || review.title!.isEmpty){
      return ValidationResult(false,message: AppText.errorTitleCanNotBeEmpty.capitalizeFirstWord.get);
    }
    if(review.content == null || review.content!.isEmpty){
      return ValidationResult(false,message: AppText.errorContentCanNotBeEmpty.capitalizeFirstWord.get);
    }
    return ValidationResult(true);
  }
}
