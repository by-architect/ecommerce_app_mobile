import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFireStore extends Mock implements FirebaseFirestore{}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockFirestore = MockFireStore();

  // Optionally mock other Firebase services


}

Future<void> addProducts(FirebaseFirestore fireStore) async {
  for (var product in FakeProductModels.products) {
      await fireStore.collection(FireStoreCollections.products).doc(product.id).set(product.toMap()).onError(
        (error, stackTrace) {
          print(error.toString());
          expect(true, false);
        },
      ).then(
        (value) {
          print("success");
        },
      );
    }
}
