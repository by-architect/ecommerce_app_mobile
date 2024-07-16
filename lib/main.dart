import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppTheme.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/SignInScreen.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/SignUpScreen.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:ecommerce_app_mobile/presentation/splash/bloc/welcome_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/splash/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MainBlocs()),
        BlocProvider(create: (BuildContext context) => WelcomeBlocs()),
        BlocProvider(create: (BuildContext context) => UserBloc()),
        BlocProvider(create: (BuildContext context) => UserServiceBloc()),
      ],
      child: BlocBuilder<MainBlocs, MainStates>(
        builder: (BuildContext context, MainStates state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: BlocProvider.of<MainBlocs>(context).state.themeMode,
            routes: {
              Screens.signInScreen: (context) => const SignInScreen(),
              Screens.signUpScreen: (context) => const SignUpScreen(),
            },
            home: const SignUpScreen()),
      ),
    );
  }
}
