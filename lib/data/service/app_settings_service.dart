import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

abstract class AppSettingsService {

  Future<ResourceStatus<AppSettings>> getAppSettings();

}