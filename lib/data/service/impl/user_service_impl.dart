import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/FireStoreCollections.dart';
import 'package:ecommerce_app_mobile/common/constant/exception_handler.dart';
import 'package:ecommerce_app_mobile/common/constant/timeouts.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/network_exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
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
  Future<Resource<UserResponse>> addUser(User user) async {
    try {
      var networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");
      var authResponse =
          await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password).timeout(Timeouts.postTimeout);

      var createdUserId = authResponse.user?.uid;
      if (createdUserId == null) throw FirebaseAuth.FirebaseAuthException(code: ExceptionHandler.nullUserId);
      await _fireStore
          .collection(FireStoreCollections.users)
          .doc(createdUserId)
          .set(user.copyWith(id: createdUserId).toMap())
          .timeout(Timeouts.postTimeout);
      return Resource.success(UserResponse.fromUser(user, authResponse.credential?.token, authResponse.credential?.accessToken));
    } catch (exception) {
      if (exception is FirebaseAuth.FirebaseAuthException) {
        Log.error(exception.code, exception.message ?? "");
        switch (exception.code) {
          case FirebaseExceptions.emailAlreadyInUse:
            return (Resource.fail(AppText.errorEmailHasTaken));
          case ExceptionHandler.nullUserId:
            return (Resource.fail(AppText.errorFetchingData));
          case FirebaseExceptions.networkRequestFailed:
            return (Resource.fail(AppText.errorNetworkRequestFailed));
          case FirebaseExceptions.apiNotAvailable:
          default:
            return (Resource.fail(AppText.errorFetchingData));
        }
      } else if (exception is TimeoutException) {
        Log.error("Time out:", exception.message ?? "");
        return (Resource.fail(AppText.errorTimeout));
      } else if (exception is NetworkDeviceDisconnectedException) {
        Log.error("Network Device Down", exception.message);
        return Resource.fail(AppText.errorNetworkDeviceIsDown);
      } else {
        Log.error("Unknown Error", exception.toString());
        return (Resource.fail(AppText.errorFetchingData));
      }
    }

/*    resource(Resource.loading());
    _firebaseAuth.createUserWithEmailAndPassword(email: FakeUserModels.admin.email, password: FakeUserModels.admin.password).then((authValue) {
      _fireStore.collection(FireStoreCollections.users).add(user.toMap()).then((fireStoreValue) {
        var userId = authValue.user?.uid;
        if (userId == null) {
          throw FirebaseAuth.FirebaseAuthException(
              code: ExceptionHandler.nullUserId);
        }
        UserResponse userResponse = UserResponse.fromUser(user.copyWith(id: authValue.user?.uid), authValue.credential?.token, authValue.credential?.accessToken);
        resource(Resource.success(userResponse));

      }).catchError((er) {
       if(er is FirebaseAuth.FirebaseAuthException) {
         // resource(Resource.fail(er.code));
       }

      }).timeout(Timeouts.postTimeout);
    }).catchError((e) {
      if (e is FirebaseAuth.FirebaseAuthException) {
        switch (e.code) {
          case ExceptionHandler.emailAlreadyInUse:
            resource(Resource.fail(AppText.errorEmailHasTaken));
        }
      } else {
        resource(Resource.fail(AppText.errorFetchingData));
      }
    }).timeout(Timeouts.postTimeout);*/
  }

  @override
  login(User user, Function(Resource<User>) resource) {
/*    var response = _firebaseAuth.signInWithEmailAndPassword(
        email: user.email, password: user.password);

    response.then((value) {
      Log.test(value.toString());
    });*/
  }
}
