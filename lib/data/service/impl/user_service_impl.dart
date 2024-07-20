import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/FireStoreCollections.dart';
import 'package:ecommerce_app_mobile/common/constant/exception_handler.dart';
import 'package:ecommerce_app_mobile/common/constant/timeouts.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/network_exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/network_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/model/user_response.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

import '../../../sddklibrary/constant/exceptions/firebase_exception_codes.dart';

class UserServiceImpl extends UserService {
  late final _firebaseAuth = FirebaseAuth.FirebaseAuth.instance;
  late final _fireStore = FirebaseFirestore.instance;

  @override
  Future<Resource<UserResponse>> addUser(User user, String verificationCode) async {
    try {
      //check network connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //check email verification
      final verificationStatus = await verifyEmail(verificationCode);
      if (verificationStatus.status == Status.fail) {
        throw FirebaseAuth.FirebaseAuthException(
          code: FirebaseExceptions.invalidVerificationCode,
        );
      }

      //request user creation
      final authResponse =
          await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password).timeout(Timeouts.postTimeout);
      final createdUserId = authResponse.user?.uid;
      if (createdUserId == null) throw FirebaseAuth.FirebaseAuthException(code: ExceptionHandler.nullUserId);

      //create user to fire store
      await _fireStore
          .collection(FireStoreCollections.users)
          .doc(createdUserId)
          .set(user.copyWith(id: createdUserId).toMap())
          .timeout(Timeouts.postTimeout);
      return Resource.success(
          UserResponse.fromUser(user, token: authResponse.credential?.token, accessToken: authResponse.credential?.accessToken));

      //catch exceptions
    } catch (exception) {
      if (exception is FirebaseAuth.FirebaseAuthException) {
        Log.error(exception.code, exception.message ?? "");
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
          case FirebaseExceptions.apiNotAvailable:
            return Resource.fail(
                DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code));
          default:
            return (Resource.fail(
                DefaultError(userMessage: AppText.errorFetchingData, exception: exception.message, errorCode: exception.code)));
        }
      } else if (exception is TimeoutException) {
        Log.error("Time out:", exception.message ?? "");
        return (Resource.fail(DefaultError(userMessage: AppText.errorTimeout, exception: exception.message)));
      } else if (exception is NetworkDeviceDisconnectedException) {
        Log.error("Network Device Down", exception.message);
        return Resource.fail(DefaultError(userMessage: AppText.errorNetworkDeviceIsDown, exception: exception.message));
      } else {
        Log.error("Unknown Error", exception.toString());
        return (Resource.fail(DefaultError(userMessage: AppText.errorFetchingData, exception: exception.toString())));
      }
    }
  }

  @override
  Future<Resource> verifyEmail(String code) {
    throw UnimplementedError();
  }

  @override
  Future<Resource> sendEmailVerificationCode(String email) async {
    try {
      var networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //todo: send verification code using firebase extentions

      // final resp = await _firebaseAuth.signInWithEmailAndPassword(email: FakeUserModels.emin.email, password: FakeUserModels.emin.password);
      // Log.test("curernt user", message: resp.user.toString());
      //  final response = await resp.user?.sendEmailVerification();

      // _firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: FirebaseAuth.ActionCodeSettings())
      return Resource.success("");
    } catch (e) {
      return Resource.fail(DefaultError(userMessage: AppText.errorFetchingData));
    }
  }
}
