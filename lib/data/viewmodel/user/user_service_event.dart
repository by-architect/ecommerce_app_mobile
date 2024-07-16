import '../../model/user.dart';

class UserServiceEvent{}

class AddUser extends UserServiceEvent {
 final User user ;

 AddUser(this.user);
}