import '../../model/user.dart';

class UserServiceEvent{}

class AddUserEvent extends UserServiceEvent {
 final User user ;

 AddUserEvent(this.user);
}