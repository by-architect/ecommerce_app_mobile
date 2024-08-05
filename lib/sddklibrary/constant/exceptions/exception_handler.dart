import 'dart:async';

import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/firebase_exception_codes.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'exceptions.dart';
import 'firebase_error_messages.dart';
import '../../helper/Helper.dart';
import '../../helper/Log.dart';
import '../../helper/error.dart';
import '../../helper/resource.dart';
import '../../../common/ui/theme/AppText.dart';

class ExceptionHandler extends FirebaseExceptions {
  static const nullUserId = "null-user-id";
  static const metadataNotExist = "metadata-not-exist";


  static ResourceStatus<T> firebaseResourceExceptionHandler<T>(Object exception,StackTrace stackTrace) {
    if (exception is firebase_auth.FirebaseAuthException) {
      // Log.error(exception.code, exception.message ?? "");
      switch (exception.code) {
        case FirebaseExceptions.emailAlreadyInUse:
          return (ResourceStatus.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseEmailAlreadyInUse, exception: exception.message, errorCode: exception.code)));
        case ExceptionHandler.nullUserId:
          return (ResourceStatus.fail(
              DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
        case FirebaseExceptions.networkRequestFailed:
          return (ResourceStatus.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseNetworkRequestFailed,
              exception: exception.message,
              errorCode: exception.code)));
        case FirebaseExceptions.invalidVerificationCode:
          return ResourceStatus.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseInvalidVerificationCode,
              exception: exception.message,
              errorCode: exception.code));
        case FirebaseExceptions.appNotInstalled:
          return ResourceStatus.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseAppNotInstalled, exception: exception.message, errorCode: exception.code));
        case FirebaseExceptions.wrongPassword:
          return ResourceStatus.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseWrongPassword, exception: exception.message, errorCode: exception.code));
        default:
          if (Helper.systemLanguageCode == 'en') {
            return ResourceStatus.fail(
                DefaultError(userMessage: exception.message ?? "", exception: exception.message, errorCode: exception.code));
          } else {
            return (ResourceStatus.fail(
                DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
          }
      }
    } else if (exception is TimeoutException) {
      // Log.error("Time out:", exception.message ?? "");
      return (ResourceStatus.fail(DefaultError(userMessage: AppText.errorTimeout, exception: exception.message)));
    } else if (exception is NetworkDeviceDisconnectedException) {
      // Log.error("Network Device Down", exception.message);
      return ResourceStatus.fail(DefaultError(userMessage: AppText.errorNetworkDeviceIsDown, exception: exception.message));
    }
      else if(exception is NullDataException){
       return ResourceStatus.fail(DefaultError(userMessage: AppText.errorFetchingData,exception: exception.message));
    } else {
      // Log.error("Unknown Error", exception.toString());
      return (ResourceStatus.fail(DefaultError(userMessage: AppText.errorFetchingData, exception: exception.toString())));
    }
  }
}

