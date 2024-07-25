import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/email_verification_screen.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarPopUp.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../../common/constant/gender.dart';
import '../bloc/user_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late UserRequestState globalUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DialogUtil dialogUtil = DialogUtil(context);

    Future<void> verifyUser() async {
      final userState = BlocProvider.of<UserBloc>(context).state;
      final userValidation = UserValidation.validateRegistration(userState);

      if (userValidation.success) {
        globalUser = userState;

        BlocProvider.of<UserServiceBloc>(context).add(AddUserEvent(globalUser));

        late StreamSubscription<UserServiceState> subscription;
        subscription = BlocProvider.of<UserServiceBloc>(context).stream.listen((state) {
          switch (state) {
            case AddUserSuccessState userSuccessState:
              BlocProvider.of<UserServiceBloc>(context).add(SendVerificationCodeEvent(userSuccessState.user));
              break;
            case AddUserFailState failState:
              dialogUtil.info(AppText.errorTitle, failState.error.userMessage);
              subscription.cancel();
              break;
            case SendVerificationEmailSuccessState sendVerificationEmailSuccessState:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EmailVerificationScreen(user: sendVerificationEmailSuccessState.user)));
              subscription.cancel();
              break;
            case SendVerificationEmailFailState failState:
              dialogUtil.info(AppText.errorTitle, failState.error.userMessage);
              subscription.cancel();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
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
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields / 2),
                        child: TextFieldAuthentication(
                          icon: Icons.date_range,
                          label: AppText.birthYear,
                          onChanged: (value) {
                            BlocProvider.of<UserBloc>(context).add(BirthYearEvent(value));
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (BuildContext context, UserState state) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: AppStyles.defaultBoxDecoration(),
                            child: DropdownButton<Gender>(
                              style: BlocProvider.of<UserBloc>(context).state.gender == Gender.unselected
                                  ? AppStyles.bodyMediumLight
                                  : AppStyles.bodyMediumLight.copyWith(color: Colors.black),
                              underline: const SizedBox.shrink(),
                              value: BlocProvider.of<UserBloc>(context).state.gender,
                              hint: Text(BlocProvider.of<UserBloc>(context).state.gender.text),
                              onChanged: (Gender? newValue) {
                                BlocProvider.of<UserBloc>(context).add(GenderEvent(newValue ?? Gender.unselected));
                              },
                              items: Gender.toList().map<DropdownMenuItem<Gender>>((Gender gender) {
                                return DropdownMenuItem<Gender>(
                                  value: gender,
                                  child: Text(gender.text),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
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
                TextFieldAuthentication(
                    icon: Icons.password,
                    label: AppText.passwordConfirm,
                    isPassword: true,
                    onChanged: (value) {
                      BlocProvider.of<UserBloc>(context).add(PasswordConfirmEvent(value));
                    }),
                const SizedBox(
                  height: AppSizes.spaceBtwVerticalFields,
                ),
                /*
                TextFieldPhoneNo(onChanged: (value) {
                  BlocProvider.of<UserBloc>(context).add(PhoneNoEvent(value));
                }),
            */
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppText.signUpScreenAlreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: AppSizes.spaceBtwHorizontalFields,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(Screens.signInScreen),
                      child: Text(
                        AppText.signIn,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.linkColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              child: BlocBuilder<UserServiceBloc, UserServiceState>(builder: (BuildContext context, UserServiceState state) {
                return ButtonPrimary(
                  text: AppText.commonNext,
                  loading: state is AddUserLoadingState || state is SendVerificationEmailLoadingState,
                  onTap: verifyUser,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

//todo: errors in textfields
//todo: expend user for firestore
