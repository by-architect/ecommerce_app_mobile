import 'dart:async';

import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/firebase_exception_codes.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../sddklibrary/constant/exceptions/network_exceptions.dart';
import '../../sddklibrary/constant/firebase_error_messages.dart';
import '../../sddklibrary/helper/Helper.dart';
import '../../sddklibrary/helper/Log.dart';
import '../../sddklibrary/helper/error.dart';
import '../../sddklibrary/helper/resource.dart';
import '../ui/theme/AppText.dart';

class ExceptionHandler extends FirebaseExceptions {
  static const nullUserId = "null-user-id";
  static const metadataNotExist = "metadata-not-exist";

  static Resource<T> firebaseResourceExceptionHandler<T>(Object exception) {
    if (exception is firebase_auth.FirebaseAuthException) {
      Log.error(exception.code, exception.message ?? "");
      switch (exception.code) {
        case FirebaseExceptions.emailAlreadyInUse:
          return (Resource.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseEmailAlreadyInUse, exception: exception.message, errorCode: exception.code)));
        case ExceptionHandler.nullUserId:
          return (Resource.fail(
              DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
        case FirebaseExceptions.networkRequestFailed:
          return (Resource.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseNetworkRequestFailed,
              exception: exception.message,
              errorCode: exception.code)));
        case FirebaseExceptions.invalidVerificationCode:
          return Resource.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseInvalidVerificationCode,
              exception: exception.message,
              errorCode: exception.code));
        case FirebaseExceptions.appNotInstalled:
          return Resource.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseAppNotInstalled, exception: exception.message, errorCode: exception.code));
        case FirebaseExceptions.wrongPassword:
          return Resource.fail(DefaultError(
              userMessage: FirebaseErrorMessages.errorFirebaseWrongPassword, exception: exception.message, errorCode: exception.code));
        default:
          if (Helper.systemLanguageCode == 'en') {
            return Resource.fail(
                DefaultError(userMessage: exception.message ?? "", exception: exception.message, errorCode: exception.code));
          } else {
            return (Resource.fail(
                DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
          }
      }
    } else if (exception is TimeoutException) {
      Log.error("Time out:", exception.message ?? "");
      return (Resource.fail(DefaultError(userMessage: AppText.errorTimeout, exception: exception.message)));
    } else if (exception is NetworkDeviceDisconnectedException) {
      Log.error("Network Device Down", exception.message);
      return Resource.fail(DefaultError(userMessage: AppText.errorNetworkDeviceIsDown, exception: exception.message));
    }
      else if(exception is NullDataException){
       return Resource.fail(DefaultError(userMessage: AppText.errorFetchingData,exception: exception.message));
    } else {
      Log.error("Unknown Error", exception.toString());
      return (Resource.fail(DefaultError(userMessage: AppText.errorFetchingData, exception: exception.toString())));
    }
  }
}

class NullDataException implements Exception{
  final message;

  NullDataException(this.message);
}