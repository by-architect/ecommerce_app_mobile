import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:latlong2/latlong.dart';

class FakeAppDefaults{
  static int maxProductQuantityCustomerCanBuyInOnce = 5; //disable if product has not its own max quantity
  static double shippingFee = 50;
  static LatLng defaultStartLocation = const LatLng(36.811260, 34.618270);
  static Currency defaultCurrency = Currency.usd;
  static int defaultReturnDays = 15;
}