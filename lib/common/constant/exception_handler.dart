import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/firebase_exception_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../sddklibrary/helper/error.dart';
import '../../sddklibrary/helper/resource.dart';
import '../ui/theme/AppText.dart';

class ExceptionHandler extends FirebaseExceptions {
  static const nullUserId = "null-user-id";
  static const metadataNotExist = "metadata-not-exist";

/*
  static Resource<T> firebaseExceptionHandler<T>(FirebaseAuthException exception) {
    switch (exception.code) {
      case FirebaseExceptions.emailAlreadyInUse:
        return (Resource.fail(
            DefaultError(userMessage: AppText.errorEmailHasTaken, exception: exception.message, errorCode: exception.code)));
      case ExceptionHandler.nullUserId:
        return (Resource.fail(
            DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
      case FirebaseExceptions.networkRequestFailed:
        return (Resource.fail(
            DefaultError(userMessage: AppText.errorNetworkRequestFailed, exception: exception.message, errorCode: exception.code)));
      case FirebaseExceptions.invalidVerificationCode:
        return Resource.fail(
            DefaultError(userMessage: AppText.errorVerificationCodeIsWrong, exception: exception.message, errorCode: exception.code));
      default:
        return (Resource.fail(
            DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
    }
  }
*/
}
