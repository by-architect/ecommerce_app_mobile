import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_in_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../data/usecase/user_validation.dart';
import '../../main/bloc/main_blocs.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late StreamSubscription<SignInState>? streamSubscription;

  @override
  void initState() {
    streamSubscription = null;
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    streamSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DialogUtil dialogUtil = DialogUtil(context);

    void verifyUser() {
      final userState = BlocProvider.of<SignInBloc>(context).state;
      final userValidation = UserValidation.validateLogin(userState);
      if (userValidation.success) {
        BlocProvider.of<SignInBloc>(context).add(SignInRequestEvent());
        streamSubscription =
            BlocProvider.of<SignInBloc>(context).stream.listen((state) {
          switch (state) {
            case SignInSuccessState signInSuccessState:
              BlocProvider.of<MainBlocs>(context)
                  .add(UserSignedInEvent(signInSuccessState.user));
              Navigator.of(context).pushNamedAndRemoveUntil(
                Screens.mainScreen,
                (route) => false,
              );
              streamSubscription?.cancel();
              break;
            case SignInFailState failState:
              dialogUtil.info(AppText.errorTitle.capitalizeEveryWord.get,
                  failState.fail.userMessage);
              break;
          }
        });
      } else {
        dialogUtil.toast(userValidation.message);
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Flexible(
              child: Image.asset(
            FakeProductModels.loginDemoImage,
            fit: BoxFit.fitWidth,
          )),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: Column(
              children: [
                TextFieldAuthentication(
                  icon: Icons.email,
                  label: AppText.email.capitalizeFirstWord.get,
                  onChanged: (value) {
                    BlocProvider.of<SignInBloc>(context).add(EmailEvent(value));
                  },
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwVerticalFields,
                ),
                TextFieldAuthentication(
                  icon: Icons.password,
                  label: AppText.password.capitalizeFirstWord.get,
                  isPassword: true,
                  onChanged: (value) {
                    BlocProvider.of<SignInBloc>(context)
                        .add(PasswordEvent(value));
                  },
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwVerticalFieldsTooLarge,
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (BuildContext context, state) => ButtonPrimary(
                    text: AppText.signIn.capitalizeEveryWord.get,
                    loading: state is SignInLoadingState,
                    onTap: verifyUser,
                  ),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwVerticalFields,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppText
                          .signInPageDoNotHaveAnAccount.capitalizeFirstWord.get,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: AppSizes.spaceBtwHorizontalFields,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              Screens.signUpScreen, (route) => false),
                      child: Text(
                        AppText.signUp.capitalizeEveryWord.get,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.linkColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
