
import '../../presentation/authentication/bloc/user_state.dart';

class FakeUserModels{
  static UserState emin = UserState(name: "emin",surname:  "demir",email:  "emindemir1541@proton.me",password:  "testpassword",phoneNo:"555 345-4334" );
  static UserState test = UserState(name: "test", surname: "test",email:  "test",password:  "test",  phoneNo:"555 345-4334" );
  static UserState admin = UserState(name: "admin",surname:  "admin",email:  "admin@mail.com",password:  "adminTest",phoneNo:"555 345-4334" );
  static UserState testValidUser = UserState(name: "admin",surname:  "admin",email:  "admin@mail.com",password:  "adminTest",phoneNo:"555 345-4334"  );

}