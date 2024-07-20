import 'dart:async';

import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldPhoneNo.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarPopUp.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../bloc/user_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late UserState globalUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DialogUtil dialogUtil = DialogUtil(context);

    Future<void> verifyUser() async {
      final userState = BlocProvider.of<UserBloc>(context).state;
      final userValidation = UserValidation.validate(userState);

      if (userValidation.success) {
        globalUser = userState;

        BlocProvider.of<UserServiceBloc>(context).add(AddUserEvent(globalUser));

        late StreamSubscription<UserServiceState> subscription;
        subscription = BlocProvider
            .of<UserServiceBloc>(context)
            .stream
            .listen((state) {
          switch (state) {
            case AddUserLoadingState _:
              break;
            case AddUserSuccessState _:
               Navigator.of(context).pushNamed(Screens.emailVerificationScreen);
            Log.test("success?");
              subscription.cancel();
              break;
            case AddUserFailState failState:
              dialogUtil.info(AppText.errorTitle, failState.error.userMessage);
              subscription.cancel();
              break;
            default:
              break;
          }
        });

      } else {
        dialogUtil.toast(userValidation.message);
      }
    }

    return Scaffold(

      appBar: const AppBarPopUp(
        text: AppText.signUp,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const Expanded(flex:1,child: SizedBox()),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields / 2),
                          child: TextFieldAuthentication(
                            icon: Icons.person,
                            label: AppText.name,
                            onChanged: (value) {
                              BlocProvider.of<UserBloc>(context).add(NameEvent(value));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                          child: TextFieldAuthentication(
                              icon: Icons.person,
                              label: AppText.surname,
                              onChanged: (value) {
                                BlocProvider.of<UserBloc>(context).add(SurnameEvent(value));
                              }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  TextFieldAuthentication(
                      icon: Icons.email,
                      label: AppText.email,
                      onChanged: (value) {
                        BlocProvider.of<UserBloc>(context).add(EmailEvent(value));
                      }),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  TextFieldAuthentication(
                      icon: Icons.password,
                      label: AppText.password,
                      isPassword: true,
                      onChanged: (value) {
                        BlocProvider.of<UserBloc>(context).add(PasswordEvent(value));
                      }),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  TextFieldPhoneNo(onChanged: (value) {
                    BlocProvider.of<UserBloc>(context).add(PhoneNoEvent(value));
                  }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 60,
                child: BlocBuilder<UserServiceBloc, UserServiceState>(builder: (BuildContext context, UserServiceState state) {
                  return ButtonPrimary(
                    text: AppText.commonNext,
                    loading: state is AddUserLoadingState,
                    onTap: verifyUser,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*class _Page extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final String buttonOneText;
  String? buttonTwoText;
  final Function() onButtonOneTap;
  Function()? onButtonTwoTap;

  _Page({
    required this.title,
    required this.content,
    required this.image,
    required this.buttonOneText,
    required this.onButtonOneTap,
    this.buttonTwoText,
    this.onButtonTwoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: SvgPicture.asset(image),
        ),
        const SizedBox(
          height: 70.0,
        ),
        Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(
          height: 8,
        ),
        Text(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 100.0,
          width: 0,
        ),
        GestureDetector(
            onTap: onButtonOneTap,
            child: ButtonPrimary(
              primaryDecoration: false,
              text: buttonOneText,
            )),
        const SizedBox(
          height: AppSizes.spaceBtwVerticalFields,
        ),
        buttonTwoText == null
            ? const SizedBox()
            : GestureDetector(
                onTap: onButtonTwoTap,
                child: ButtonPrimary(
                  text: buttonTwoText!,
                  primaryDecoration: false,
                ),
              )
      ],
    );
  }
}*/
//todo: on back pressed go to previous page view with controller or put back button
/*
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(textAlign: TextAlign.center, AppText.verificationEmailTitle, style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge),
                          Text(textAlign: TextAlign.center, AppText.verificationEmailBody, style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFieldsLarge,
                    ),
                    VerificationCodeWidget(onCompleted: (code) {
                      BlocProvider.of<UserServiceBloc>(context).add(AddUserEvent(globalUser, code));

                      late StreamSubscription<UserServiceState> subscription;
                      subscription = BlocProvider
                          .of<UserServiceBloc>(context)
                          .stream
                          .listen((state) {
                        switch (state) {
                          case AddUserLoadingState _:
                            dialogUtil.loading();
                          case AddUserSuccessState _:
                            dialogUtil.closeLoadingDialog();
                            Navigator.of(context).pushNamedAndRemoveUntil(Screens.homeScreen, (route) => false);
                            subscription.cancel();
                          case AddUserFailState failState:
                            dialogUtil.closeLoadingDialog();
                            DialogUtil(context).toast( failState.error.userMessage);
                           subscription.cancel();
                          default:
                            dialogUtil.closeLoadingDialog();
                        }
                      });
                    })
                  ],
                )
              ],
            )
*/
