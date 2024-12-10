import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

class AppDatabase {
  static const _appDatabaseName = "app_database";
  static const _hideWelcomeScreenKey = "hide_welcome_screen";
  static const _lastLocationLatKey = "last_location_lat";
  static const _lastLocationLngKey = "last_location_lng";

  late final Box box;

  Future<AppDatabase> open() async {
    box = await Hive.openBox(_appDatabaseName);
    return this;
  }

  Future<void> dispose() async {
   await Hive.close();
  }

  Future<void> hideWelcomeScreen() async {
    await box.put(_hideWelcomeScreenKey, true);
    Log.test(data: await box.get(_hideWelcomeScreenKey));
  }

  Future<void> create() async {
    await box.put(_hideWelcomeScreenKey, false);
  }

  Future<bool> get isHideWelcomeScreen async => await box.get(_hideWelcomeScreenKey, defaultValue: false);

  Future<void> addLastLocation(LatLng? location) async {
    if (location != null) {
      await box.put(_lastLocationLatKey, location.latitude);
      await box.put(_lastLocationLngKey, location.longitude);
    }
  }

  Future<LatLng> lastLocation(LatLng defaultStartLocation) async => LatLng(
      await box.get(_lastLocationLatKey, defaultValue: defaultStartLocation.latitude) ?? defaultStartLocation.latitude,
      await box.get(_lastLocationLngKey, defaultValue: defaultStartLocation.longitude) ?? defaultStartLocation.longitude);
}
