import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:latlong2/latlong.dart';

class FakeAppDefaults{
  static int maxQuantityOfProduct = 5;
  static double shippingFee = 50;
  static LatLng defaultStartLocation = const LatLng(36.811260, 34.618270);
  static Currency defaultCurrency = Currency.usd;
}