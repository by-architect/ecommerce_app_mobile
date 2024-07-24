
import '../../presentation/authentication/bloc/user_state.dart';

class FakeUserModels{
  static UserRequestState emin = UserRequestState(name: "emin",surname:  "demir",email:  "emindemir1541@proton.me",password:  "testpassword");
  static UserRequestState test = UserRequestState(name: "test", surname: "test",email:  "test",password:  "test",  );
  static UserRequestState admin = UserRequestState(name: "admin",surname:  "admin",email:  "admin@mail.com",password:  "adminTest",);
  static UserRequestState testValidUser = UserRequestState(name: "admin",surname:  "admin",email:  "admin@mail.com",password:  "adminTest",);

}