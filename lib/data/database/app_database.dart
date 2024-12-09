import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

class AppDatabase {
  static const _appDatabaseName = "app_database";
  static const _hideWelcomeScreenKey = "hide_welcome_screen";
  static const _lastLocationLatKey = "last_location_lat";
  static const _lastLocationLngKey = "last_location_lng";

  late final Box box;

  Future<void> open() async {
    box = await Hive.openBox(_appDatabaseName);
  }

  void dispose() {
    Hive.close();
  }

  void hideWelcomeScreen() {
    box.put(_hideWelcomeScreenKey, true);
  }

  bool get isHideWelcomeScreen =>
      box.get(_hideWelcomeScreenKey, defaultValue: true);

  void addLastLocation(LatLng? location) {
    if (location != null) {
      box.put(_lastLocationLatKey, location.latitude);
      box.put(_lastLocationLngKey, location.longitude);
    }
  }

  LatLng lastLocation(LatLng defaultStartLocation) => LatLng(
      box.get(_lastLocationLatKey,
              defaultValue: defaultStartLocation.latitude) ??
          defaultStartLocation.latitude,
      box.get(_lastLocationLngKey,
              defaultValue: defaultStartLocation.longitude) ??
          defaultStartLocation.longitude);
}
