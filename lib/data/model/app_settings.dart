import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/data/model/communication_model.dart';
import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/enum_helper.dart';
import 'package:latlong2/latlong.dart';

import 'money.dart';

class AppSettings {
  final int maxProductQuantityCustomerCanBuyInOrder;
  final Money defaultShippingFee;
  final LatLng defaultMapLocation;
  final Currency defaultCurrency;
  final int defaultReturnDay;
  final bool isAppLocked;
  final bool updateAvailable;
  final bool forceUpdate;

  // final String defaultLanguage;
  final List<ContactModel> contacts;

  @TestOnly()
  const AppSettings.testOnly(
      {required this.maxProductQuantityCustomerCanBuyInOrder,
      required this.defaultShippingFee,
      required this.updateAvailable,
      required this.forceUpdate,
      required this.isAppLocked,
      required this.defaultMapLocation,
      required this.defaultCurrency,
      required this.defaultReturnDay,
      // required this.defaultLanguage,
      required this.contacts});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings._(
        maxProductQuantityCustomerCanBuyInOrder: json['maxProductQuantityCustomerCanBuyInOrder'] as int,
        defaultShippingFee: Money.fromJson(json['defaultShippingFee']),
        updateAvailable: json['updateAvailable'] as bool,
        forceUpdate: json['forceUpdate'] as bool,
        isAppLocked: json['isAppLocked'] as bool,
        defaultMapLocation: LatLng.fromJson(json['defaultMapLocation'] as Map<String, dynamic>),
        defaultCurrency: EnumHelper.fromJson(Currency.values, json['defaultCurrency'] as String),
        defaultReturnDay: json['defaultReturnDay'] as int,
        contacts: (json['contacts'] as List<dynamic>).map((e) => ContactModel.fromJson(e as Map<String, dynamic>)).toList());
  }

  @TestOnly()
  Map<String, dynamic> toJson() {
    return {
      'maxProductQuantityCustomerCanBuyInOrder': maxProductQuantityCustomerCanBuyInOrder,
      'defaultShippingFee': defaultShippingFee.amount,
      'updateAvailable': updateAvailable,
      'forceUpdate': forceUpdate,
      'isAppLocked': isAppLocked,
      'defaultMapLocation': defaultMapLocation.toJson(),
      'defaultCurrency': defaultCurrency.toJson(),
      'defaultReturnDay': defaultReturnDay,
      'contacts': contacts.map((contact) => contact.toJson()).toList(),
    };
  }

  AppSettings._({
    required this.maxProductQuantityCustomerCanBuyInOrder,
    required this.defaultShippingFee,
    required this.forceUpdate,
    required this.updateAvailable,
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
        updateAvailable: false,
        forceUpdate: false,
        defaultMapLocation: const LatLng(39.9334, 32.8597),
        defaultCurrency: Currency.tl,
        isAppLocked: false,
        contacts: [],
        defaultReturnDay: 14);
  }
}
