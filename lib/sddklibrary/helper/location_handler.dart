import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationHandler {
  Future<ResourceStatus<LatLng>> getLocation() async {
    Location locationService = Location();

    if (await locationService.hasPermission() == PermissionStatus.denied) {
      await locationService.requestPermission();
      if (await locationService.hasPermission() == PermissionStatus.denied) {
        return ResourceStatus.fail(Fail(
          exception: "Location permission denied",
          stackTrace: StackTrace.current,
          userMessage: AppText.errorGettingLocationPermission.capitalizeFirstWord,
        ));
      }
    }

    if (!await locationService.serviceEnabled()) {
      await locationService.requestService();
      if (!await locationService.serviceEnabled()) {
        return ResourceStatus.fail(Fail(
            exception: "Location permission denied",
            stackTrace: StackTrace.current,
            userMessage: AppText.errorOpeningLocationService.capitalizeFirstWord));
      }
    }

    try {
      LocationData locationData = await locationService.getLocation();
      return ResourceStatus.success(LatLng(locationData.latitude!, locationData.longitude!));
    } catch (e, s) {
      return ResourceStatus.fail(
          Fail(userMessage: AppText.errorGettingLocation.capitalizeFirstWord, exception: e, stackTrace: s));
    }
  }}
