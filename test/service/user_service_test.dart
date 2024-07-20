import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:ecommerce_app_mobile/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
 test("userService_addUserTest", () async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebase = FirebaseAuth.instance;
  final response = await firebase.isSignInWithEmailLink("emindemir1541@proton.me");
  expect(response, true) ;
 });
}