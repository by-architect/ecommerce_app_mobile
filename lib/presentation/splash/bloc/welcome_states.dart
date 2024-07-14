class WelcomeStates{
  int pageState;

  WelcomeStates({required this.pageState});

}
class InitialWelcomeStates extends WelcomeStates{
  InitialWelcomeStates(): super(pageState: 0);

}