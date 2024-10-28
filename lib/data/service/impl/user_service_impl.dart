import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_state.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exception_handler.dart';
import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/firebase_exception_codes.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/network_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../sddklibrary/constant/exceptions/exceptions.dart';
import '../../model/user.dart';

class UserServiceImpl extends UserService {
  late final _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  late final _fireStore = FirebaseFirestore.instance;

  @override
  Future<ResourceStatus<User>> addUser(SignUpState signUpState) async {
    try {
      //check network connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //request user creation
      final authResponse = await _firebaseAuth
          .createUserWithEmailAndPassword(email: signUpState.email, password: signUpState.password)
          .timeout(AppDurations.postTimeout);
      final responseUser = authResponse.user;
      if (responseUser == null) throw firebase_auth.FirebaseAuthException(code: ExceptionHandler.nullUserId);

      //create user to fire store
      await _fireStore
          .collection(FireStoreCollections.users)
          .doc(responseUser.uid)
          .set(signUpState.toMap(responseUser.uid))
          .timeout(AppDurations.postTimeoutLarge);
      final User userFinal = User.fromUserState(signUpState, responseUser, authResponse);
      return ResourceStatus.success(userFinal);

      //catch exceptions
    } catch (exception, stackTrace) {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        _fireStore.collection(FireStoreCollections.users).doc(firebaseUser.uid);
        firebaseUser.delete();
      }
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<User>> sendVerificationEmail(User user) async {
    try {
      var networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      await user.firebaseUser.sendEmailVerification();

      return ResourceStatus.success(user);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus> changePassword(User user, ChangePasswordState state) async {
    try {
      var networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      await user.firebaseUser.reauthenticateWithCredential(
          firebase_auth.EmailAuthProvider.credential(email: user.email, password: state.oldPassword));

      firebase_auth.User? firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        return ResourceStatus.fail(Fail(
            userMessage: AppText.errorCouldNotChangedThePassword.capitalizeFirstWord.get,
            exception: "Current user is Null",
            stackTrace: StackTrace.current));
      }

      await firebaseUser.updatePassword(state.newPassword);
      await _fireStore.collection(FireStoreCollections.users).doc(user.uid).update({'password': state.newPassword});
      return const ResourceStatus.success("");
    } catch (e, s) {
      if (e is firebase_auth.FirebaseAuthException && e.code == FirebaseExceptions.invalidCredential) {
        return ResourceStatus.fail(Fail(
            userMessage: AppText.errorPasswordIsIncorrect.capitalizeFirstWord.get,
            stackTrace: s,
            exception: e,
            errorCode: e.code));
      }
      return ExceptionHandler.firebaseResourceExceptionHandler(e, s);
    }
  }

  @override
  Future<ResourceStatus<User>> editUserSettings(User user, EditProfileState userState) async {
    try {
      var networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      firebase_auth.User? firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        throw firebase_auth.FirebaseAuthException(code: FirebaseExceptions.nullUser);
      }

      await _fireStore.collection(FireStoreCollections.users).doc(user.uid).update(userState.toMap(user.uid));
      final updatedUser = await getUser(userCredential: user.userCredential);

      return updatedUser;
    } catch (e, s) {
      return ExceptionHandler.firebaseResourceExceptionHandler(e, s);
    }
  }

  @override
  Future<ResourceStatus<User>> isEmailVerified() async {
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      await _firebaseAuth.currentUser?.reload();

      final userResponse = await getUser();
      if (userResponse.status == Status.fail) {
        return ResourceStatus.fail(
            userResponse.error ?? Fail(userMessage: AppText.errorFetchingData.capitalizeFirstWord.get));
      }
      User user = userResponse.data!;
      return ResourceStatus.success(user);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<User>> signIn(SignInState signInState) async {
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      var userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(email: signInState.email, password: signInState.password);
      var userResponse = await getUser(userCredential: userCredential);
      if (userResponse.status == Status.fail) {
        return ResourceStatus.fail(
            userResponse.error ?? Fail(userMessage: AppText.errorFetchingData.capitalizeFirstWord.get));
      }
      User user = userResponse.data!;
      // User user = User.fromUserState(userRequest, userCredential.user!, userCredential);

      return ResourceStatus.success(user);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus> signOut() async {
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      await _firebaseAuth.signOut();

      return const ResourceStatus.success("");
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  bool isUserAuthenticated() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<ResourceStatus<User>> getUser({firebase_auth.UserCredential? userCredential}) async {
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      await _firebaseAuth.currentUser?.reload();
      if (_firebaseAuth.currentUser == null) {
        throw UserNotAuthenticatedException("User is not authenticated");
      }
      final firebaseUser = _firebaseAuth.currentUser!;

      final fireStoreUserMap = await _fireStore
          .collection(FireStoreCollections.users)
          .doc(firebaseUser.uid)
          .get()
          .timeout(AppDurations.postTimeout);
      if (!fireStoreUserMap.exists || fireStoreUserMap.data() == null) {
        return ResourceStatus.fail(Fail(
            stackTrace: StackTrace.current,
            userMessage: AppText.errorFetchingData.capitalizeFirstWord.get,
            exception: "User exist in firebase auth, not exist in fireStore"));
        //todo: this error message should send to me with logs
      }
      final user = User.fromMap(fireStoreUserMap.data()!, firebaseUser, userCredential: userCredential);
      return ResourceStatus.success(user);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }
}
