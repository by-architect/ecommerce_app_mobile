import 'dart:async';

import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/service/map_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import 'package:http/http.dart' as http;
import '../../../common/constant/api_constants.dart';
import '../../../presentation/address/bloc/add_address_state.dart';
import '../../../sddklibrary/constant/exceptions/exceptions.dart';
import '../../../sddklibrary/helper/network_helper.dart';

class MapServiceImpl implements MapService {
  @override
  Future<ResourceStatus<AddressState>> getAddressFromLongLtd(double latitude, double longitude) async {
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }
      var url = Uri.parse(
          "${ApiConst.openCageBase}${ApiConst.openCageGeocode}json?q=$longitude%252C$latitude&key=${ApiConst.openCageApiKey}");
      var response = await http.get(url).timeout(AppDurations.postTimeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final addressState = AddressState.fromMapService(response.body);
        return ResourceStatus.success(addressState);
      } else {
        return ResourceStatus.fail(Fail(
            userMessage: AppText.errorFetchingData.capitalizeFirstWord, errorCode: response.statusCode.toString()));
      }
    } catch (exception, stackTrace) {
      if (exception is TimeoutException) {
        return (ResourceStatus.fail(
            Fail(userMessage: AppText.errorTimeout.capitalizeFirstWord, exception: exception, stackTrace: stackTrace)));
      } else if (exception is NetworkDeviceDisconnectedException) {
        return ResourceStatus.fail(Fail(
            userMessage: AppText.errorNetworkDeviceIsDown.capitalizeFirstWord,
            exception: exception,
            stackTrace: stackTrace));
      } else if (exception is NullDataException) {
        return ResourceStatus.fail(Fail(
            userMessage: AppText.errorFetchingData.capitalizeFirstWord, exception: exception, stackTrace: stackTrace));
      } else {
        return (ResourceStatus.fail(Fail(
            userMessage: AppText.errorFetchingData.capitalizeFirstWord, exception: exception, stackTrace: stackTrace)));
      }
    }
  }
}
