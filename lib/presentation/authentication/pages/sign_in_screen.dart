import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_authentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../data/usecase/user_validation.dart';
import '../bloc/user_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late StreamSubscription<UserServiceState> streamSubscription;

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DialogUtil dialogUtil = DialogUtil(context);

    void verifyUser() {
      final userState = BlocProvider.of<UserBloc>(context).state;
      final userValidation = UserValidation.validateLogin(userState);
      if (userValidation.success) {
        BlocProvider.of<UserServiceBloc>(context).add(LoginEvent(userState));
        streamSubscription =
            BlocProvider.of<UserServiceBloc>(context).stream.listen((state) {
          switch (state) {
            case LoginUserSuccessState _:
              Navigator.of(context).pushNamedAndRemoveUntil(
                Screens.mainScreen,
                (route) => false,
              );
              streamSubscription.cancel();
              break;
            case LoginUserFailState failState:
              dialogUtil.info(AppText.errorTitle.capitalizeEveryWord.get,
                  failState.error.userMessage);
              break;
          }
        });
      } else {
        dialogUtil.toast(userValidation.message);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarAuthentication(
        title: AppText.signIn.capitalizeFirstWord.get,
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: AppSizes.defaultSpace,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.facebook_rounded),
                      Icon(Icons.apple),
                    ],
                  ),
                ],
              ),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldAuthentication(
                    icon: Icons.email,
                    label: AppText.email.capitalizeFirstWord.get,
                    onChanged: (value) {
                      BlocProvider.of<UserBloc>(context).add(EmailEvent(value));
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
                      BlocProvider.of<UserBloc>(context)
                          .add(PasswordEvent(value));
                    },
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFieldsTooLarge,
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
                  )
                ],
              )),
              BlocBuilder<UserServiceBloc, UserServiceState>(
                builder: (BuildContext context, state) => ButtonPrimary(
                  text: AppText.signIn.capitalizeEveryWord.get,
                  loading: state is LoginUserLoadingState,
                  onTap: verifyUser,
                ),
              ),
            ],
          )),
    );
  }
}
