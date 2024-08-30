import 'dart:async';

import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/firebase_exception_codes.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'exceptions.dart';
import 'firebase_error_messages.dart';
import '../../helper/helper.dart';
import '../../util/Log.dart';
import '../../util/fail.dart';
import '../../util/resource.dart';
import '../../../common/ui/theme/AppText.dart';

class ExceptionHandler extends FirebaseExceptions {
  static const nullUserId = "null-user-id";
  static const metadataNotExist = "metadata-not-exist";

  static ResourceStatus<T> firebaseResourceExceptionHandler<T>(Object exception, StackTrace stackTrace) {
    if (exception is firebase_auth.FirebaseAuthException) {
      // Log.error(exception.code, exception.message ?? "");
      switch (exception.code) {
        case FirebaseExceptions.emailAlreadyInUse:
          return (ResourceStatus.fail(Fail(
              userMessage: FirebaseErrorMessages.errorFirebaseEmailAlreadyInUse,
              exception: exception.message,
              errorCode: exception.code,
              stackTrace: stackTrace)));
        case ExceptionHandler.nullUserId:
          return (ResourceStatus.fail(Fail(
              userMessage: AppText.errorFetchingData.capitalizeFirstWord,
              exception: exception.message,
              errorCode: exception.code,
              stackTrace: stackTrace)));
        case FirebaseExceptions.networkRequestFailed:
          return (ResourceStatus.fail(Fail(
              userMessage: FirebaseErrorMessages.errorFirebaseNetworkRequestFailed,
              exception: exception.message,
              errorCode: exception.code,
              stackTrace: stackTrace)));
        case FirebaseExceptions.invalidVerificationCode:
          return ResourceStatus.fail(Fail(
              userMessage: FirebaseErrorMessages.errorFirebaseInvalidVerificationCode,
              exception: exception.message,
              errorCode: exception.code,
              stackTrace: stackTrace));
        case FirebaseExceptions.appNotInstalled:
          return ResourceStatus.fail(Fail(
              userMessage: FirebaseErrorMessages.errorFirebaseAppNotInstalled,
              exception: exception.message,
              errorCode: exception.code,
              stackTrace: stackTrace));
        case FirebaseExceptions.wrongPassword:
          return ResourceStatus.fail(Fail(
              userMessage: FirebaseErrorMessages.errorFirebaseWrongPassword,
              exception: exception.message,
              errorCode: exception.code,
              stackTrace: stackTrace));
        default:
          if (Helper.systemLanguageCode == 'en') {
            return ResourceStatus.fail(Fail(
                userMessage: exception.message ?? "",
                exception: exception.message,
                errorCode: exception.code,
                stackTrace: stackTrace));
          } else {
            return (ResourceStatus.fail(Fail(
                userMessage: AppText.errorFetchingData.capitalizeFirstWord,
                exception: exception.message,
                errorCode: exception.code,
                stackTrace: stackTrace)));
          }
      }
    } else if (exception is UserNotAuthenticatedException) {
      return ResourceStatus.fail(Fail(
          userMessage: AppText.errorAuthenticate.capitalizeFirstWord,
          exception: exception,
          stackTrace: stackTrace));
    } else if (exception is TimeoutException) {
      // Log.error("Time out:", exception.message ?? "");
      return (ResourceStatus.fail(Fail(
          userMessage: AppText.errorTimeout.capitalizeFirstWord,
          exception: exception,
          stackTrace: stackTrace)));
    } else if (exception is NetworkDeviceDisconnectedException) {
      // Log.error("Network Device Down", exception.message);
      return ResourceStatus.fail(Fail(
          userMessage: AppText.errorNetworkDeviceIsDown.capitalizeFirstWord,
          exception: exception,
          stackTrace: stackTrace));
    } else if (exception is NullDataException) {
      return ResourceStatus.fail(Fail(
          userMessage: AppText.errorFetchingData.capitalizeFirstWord,
          exception: exception,
          stackTrace: stackTrace));
    } else {
      // Log.error("Unknown Error", exception.toString());
      return (ResourceStatus.fail(Fail(
          userMessage: AppText.errorFetchingData.capitalizeFirstWord,
          exception: exception.toString(),
          stackTrace: stackTrace)));
    }
  }
}
