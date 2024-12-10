import 'package:ecommerce_app_mobile/common/constant/currency.dart';
import 'package:ecommerce_app_mobile/data/model/communication_model.dart';
import 'package:latlong2/latlong.dart';

import '../model/money.dart';

class FakeAppDefaults {
  static int maxProductQuantityCustomerCanBuyInOnce =
      5; //disable if product has not its own max quantity
  static Money shippingFee = Money(50);
  static LatLng defaultStartLocation = const LatLng(39.9334, 32.8597);
  static bool isAppLocked = true;
  static Currency defaultCurrency = Currency.usd;
  static int defaultReturnDay = 14;
  static List<ContactModel> supportContacts = [
    const ContactModel(
      type: ContactType.email,
      content: "qG7oN@example.com",
    ),
    const ContactModel(
      type: ContactType.phoneNo,
      content: "0123456789",
    ),
    const ContactModel(
      type: ContactType.whatsapp,
      content: "0123456789",
    ),

  ];
}
