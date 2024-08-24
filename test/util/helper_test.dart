import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exception_handler.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("systemLanguageCode_success", () {
    expect(Helper.systemLanguageCode, "en");
  });
  test("exception watcher test", () {

    try {
      throw NetworkDeviceDisconnectedException("message");
    } catch (e) {}
  });
}
