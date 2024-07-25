import 'package:ecommerce_app_mobile/sddklibrary/helper/Helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("systemLanguageCode_success", (){
   expect(Helper.systemLanguageCode, "en") ;
  });
}