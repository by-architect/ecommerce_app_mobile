/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:ecommerce_app_mobile/firebase_options.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/network_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Create mocks
class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}
class MockFirebaseUser extends Mock implements firebase_auth.User {}
class MockFirestore extends Mock implements FirebaseFirestore {}
class MockNetworkHelper extends Mock implements NetworkHelper {}
class MockUserService extends Mock implements UserService {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}

void main(){

 group("userServiceTest", (){
  late UserService userService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirestore mockFirestore;
  late MockNetworkHelper mockNetworkHelper;

  setUp(() {
   mockFirebaseAuth = MockFirebaseAuth();
   mockFirestore = MockFirestore();
   mockNetworkHelper = MockNetworkHelper();
  });
  test("getUser success", () async {
   // Arrange
   final mockUser = MockFirebaseUser();
   when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
   when(mockUser.uid).thenReturn('test_uid');

   final mockDocSnapshot = MockDocumentSnapshot();
   when(mockDocSnapshot.exists).thenReturn(true);
   when(mockDocSnapshot.data()).thenReturn({'name': 'Test User', 'email': 'test@example.com'});

   when(mockFirestore.collection(FireStoreCollections.users).doc(mockUser.uid).get())
       .thenAnswer((_) => Future.value(mockDocSnapshot));


   // Act
   final result = await userService.getUser();

   // Assert
   expect(result, isA<Resource<User>>());
   expect(result.status, equals(Status.success));
   expect(result.data, isA<User>());
   expect(result.data?.name, equals('Test User'));

  });




 });
}*/
