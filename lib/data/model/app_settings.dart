import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/data/model/communication_model.dart';
import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';
import 'package:latlong2/latlong.dart';

import 'money.dart';

class AppSettings {
  final int maxProductQuantityCustomerCanBuyInOrder;
  final Money defaultShippingFee;
  final LatLng defaultMapLocation;
  final Currency defaultCurrency;
  final int defaultReturnDay;
  final bool isAppLocked;

  // final String defaultLanguage;
  final List<ContactModel> contacts;

  @TestOnly()
  const AppSettings.testOnly(
      {required this.maxProductQuantityCustomerCanBuyInOrder,
      required this.defaultShippingFee,
      required this.isAppLocked,
      required this.defaultMapLocation,
      required this.defaultCurrency,
      required this.defaultReturnDay,
      // required this.defaultLanguage,
      required this.contacts});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    //todo: implement
    throw UnimplementedError();
  }

  AppSettings._({
    required this.maxProductQuantityCustomerCanBuyInOrder,
    required this.defaultShippingFee,
    required this.isAppLocked,
    required this.defaultMapLocation,
    required this.defaultCurrency,
    required this.contacts,
    required this.defaultReturnDay,
  });

  static AppSettings defaultAppSettings() {
    return AppSettings._(
        maxProductQuantityCustomerCanBuyInOrder: 10,
        defaultShippingFee: Money(0),
        defaultMapLocation: const LatLng(39.9334, 32.8597),
        defaultCurrency: Currency.tl,
        isAppLocked: false,
        contacts: [],
        defaultReturnDay: 14);
  }
}
