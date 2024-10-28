class SignInEvent {
}

class EmailEvent extends SignInEvent {
  final String username;
  EmailEvent(this.username);
}

class PasswordEvent extends SignInEvent {
  final String password;
  PasswordEvent(this.password);
}

class LoginEvent extends SignInEvent{}