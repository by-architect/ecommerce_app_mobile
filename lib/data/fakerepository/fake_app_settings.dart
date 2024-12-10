import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';

import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import '../service/app_settings_service.dart';

class FakeAppSettingsService implements AppSettingsService {
  @override
  Future<ResourceStatus<AppSettings>> getAppSettings() async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(AppSettings.testOnly(
        maxProductQuantityCustomerCanBuyInOrder:
            FakeAppDefaults.maxProductQuantityCustomerCanBuyInOnce,
        defaultShippingFee: FakeAppDefaults.shippingFee,
        updateAvailable: FakeAppDefaults.updateAvailable,
        defaultMapLocation: FakeAppDefaults.defaultStartLocation,
        defaultCurrency: FakeAppDefaults.defaultCurrency,
        defaultReturnDay: FakeAppDefaults.defaultReturnDay,
        contacts: FakeAppDefaults.supportContacts, isAppLocked: FakeAppDefaults.isAppLocked));
  }
}
