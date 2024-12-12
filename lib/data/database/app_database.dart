import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDatabase {
  static const _appDatabaseName = "app_database";
  static const _hideWelcomeScreenKey = "hide_welcome_screen";
  static const _lastLocationLatKey = "last_location_lat";
  static const _lastLocationLngKey = "last_location_lng";
  static const _theme = "theme";

  final SharedPreferencesWithCache _database;

  AppDatabase._create(SharedPreferencesWithCache database) : _database = database;

  static Future<AppDatabase> create() async {
    final database = await SharedPreferencesWithCache.create(
        cacheOptions:
            const SharedPreferencesWithCacheOptions(allowList: <String>{_hideWelcomeScreenKey, _lastLocationLatKey, _lastLocationLngKey, _theme}),);
    return AppDatabase._create(database);
  }

  Future<void> hideWelcomeScreen() async {
    await _database.setBool(_hideWelcomeScreenKey, true);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await _database.setInt(_theme, themeMode.index);
  }

  Future<ThemeMode> get theme async {
    return ThemeMode.values[await _database.getInt(_theme) ?? ThemeMode.light.index];
  }

  Future<bool> get isHideWelcomeScreen async => (await _database.getBool(_hideWelcomeScreenKey)) ?? false;

  Future<void> addLastLocation(LatLng? location) async {
    if (location != null) {
      await _database.setDouble(_lastLocationLatKey, location.latitude);
      await _database.setDouble(_lastLocationLngKey, location.longitude);
    }
  }

  Future<LatLng> lastLocation(LatLng defaultStartLocation) async => LatLng(
      await _database.getDouble(_lastLocationLatKey) ?? defaultStartLocation.latitude,
      await _database.getDouble(
            _lastLocationLngKey,
          ) ??
          defaultStartLocation.longitude);
}
