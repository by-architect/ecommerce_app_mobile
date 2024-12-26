import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import '../../../common/constant/app_durations.dart';
import '../../../common/constant/firestore_collections.dart';
import '../../../sddklibrary/constant/exceptions/exception_handler.dart';
import '../../../sddklibrary/constant/exceptions/exceptions.dart';
import '../../../sddklibrary/helper/network_helper.dart';
import '../app_settings_service.dart';

class AppSettingsServiceImpl implements AppSettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ResourceStatus<AppSettings>> getAppSettings() async {
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      final snapshot = await _firestore
          .collection(FireStoreCollections.serverSettings)
          .doc(FireStoreCollections.appSettings)
          .get()
          .timeout(AppDurations.postTimeout);

      if (!snapshot.exists) {
        throw NullDataException("Could not get app settings");
      }

      return ResourceStatus.success(AppSettings.fromJson(snapshot.data()!));
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }
}
