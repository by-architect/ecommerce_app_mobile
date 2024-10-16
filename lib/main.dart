import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppTheme.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/firebase_options.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/address/pages/add_address_screen.dart';
import 'package:ecommerce_app_mobile/presentation/address/pages/addresses_screen.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_in_screen.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_up_screen.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/common/screen/loading_screen.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/page/main_screen.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/prodcut_list_screen_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/products/page/product_list_screen.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/splash/bloc/welcome_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/splash/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized(); // for use firebase before loading
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 //todo: it is for test
 //  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => MainBlocs()),
          BlocProvider(create: (BuildContext context) => WelcomeBlocs()),
          BlocProvider(create: (BuildContext context) => UserBloc()),
          BlocProvider(create: (BuildContext context) => UserServiceBloc()),
          BlocProvider(create: (BuildContext context) => DiscoverBloc()),
          BlocProvider(create: (BuildContext context) => SearchBloc()),
          BlocProvider(create: (BuildContext context) => ProductScreenBloc()),
          BlocProvider(create: (BuildContext context) => HomeBloc()),
          BlocProvider(create: (BuildContext context) => ChangePasswordBloc()),
          BlocProvider(create: (BuildContext context) => ProductDetailsBloc()),
          BlocProvider(create: (BuildContext context) => EditProfileBloc()),
          BlocProvider(create: (BuildContext context) => CartBloc()),
          BlocProvider(create: (BuildContext context) => AddressesBloc()),
          BlocProvider(create: (BuildContext context) => AddAddressBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            routes: {
              Screens.signInScreen: (context) => const SignInScreen(),
              Screens.signUpScreen: (context) => const SignUpScreen(),
              Screens.mainScreen: (context) => const MainScreen(),
              Screens.addAddressScreen: (context) => const AddAddressScreen(),
            },
            home:const MainScreen()));
  }
}
