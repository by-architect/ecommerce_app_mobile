
import '../../presentation/authentication/bloc/user_state.dart';

class FakeUserModels{
  static UserRequestState emin = UserRequestState(name: "emin",surname:  "demir",email:  "emindemir1541@proton.me",password:  "testpassword",phoneNo:"555 345-4334" );
  static UserRequestState test = UserRequestState(name: "test", surname: "test",email:  "test",password:  "test",  phoneNo:"555 345-4334" );
  static UserRequestState admin = UserRequestState(name: "admin",surname:  "admin",email:  "admin@mail.com",password:  "adminTest",phoneNo:"555 345-4334" );
  static UserRequestState testValidUser = UserRequestState(name: "admin",surname:  "admin",email:  "admin@mail.com",password:  "adminTest",phoneNo:"555 345-4334"  );

}