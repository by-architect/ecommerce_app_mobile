import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_mobile/presentation/splash/bloc/welcome_events.dart';
import 'package:ecommerce_app_mobile/presentation/splash/bloc/welcome_states.dart';

class WelcomeBlocs extends Bloc<WelcomeEvents, WelcomeStates> {
  WelcomeBlocs() : super(InitialWelcomeStates()) {
    on<WelcomeEvents>((event, emit) {

    });
  }
}
