import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/sign_up_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/dropdown_default.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_authentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../../common/constant/gender.dart';
import '../../main/bloc/main_blocs.dart';
import '../bloc/sign_up_event.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpState globalUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DialogUtil dialogUtil = DialogUtil(context);

    Future<void> verifyUser() async {
      final userState = BlocProvider.of<SignUpBloc>(context).state;
      final userValidation = UserValidation.validateRegistration(userState);

      if (userValidation.success) {
        globalUser = userState;

        BlocProvider.of<SignUpBloc>(context).add(SignUpRequestEvent());

        late StreamSubscription<SignUpState> subscription;
        subscription = BlocProvider.of<SignUpBloc>(context).stream.listen((state) {
          switch (state) {
            case SignUpRequestSuccessState signUpRequestSuccessState:
              BlocProvider.of<MainBlocs>(context).add(UserSignedInEvent(signUpRequestSuccessState.user));
              Navigator.of(context).pushNamedAndRemoveUntil(Screens.mainScreen, (route) => false);
              break;
            case SignUpRequestFailState failState:
              dialogUtil.info(AppText.errorTitle.capitalizeEveryWord.get, failState.fail.userMessage);
              subscription.cancel();
              break;
          }
        });
      } else {
        dialogUtil.toast(userValidation.message);
      }
    }

    return Scaffold(
      appBar: AppBarAuthentication(
        title: AppText.signUp.capitalizeEveryWord.get,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (BuildContext context, SignUpState state) => Padding(
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
                            label: AppText.name.capitalizeFirstWord.get,
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(NameEvent(value));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                          child: TextFieldAuthentication(
                              icon: Icons.person,
                              label: AppText.surname.capitalizeFirstWord.get,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(SurnameEvent(value));
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
                            label: AppText.birthYear.capitalizeFirstWord.get,
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(BirthYearEvent(value));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                          child: DropdownDefault(
                            value: BlocProvider.of<SignUpBloc>(context).state.gender,
                            hint: BlocProvider.of<SignUpBloc>(context).state.gender.text.capitalizeFirstWord.get,
                            onChanged: (Gender? newValue) {
                              BlocProvider.of<SignUpBloc>(context).add(GenderEvent(newValue ?? Gender.unselected));
                            },
                            items: Gender.toList().map<DropdownMenuItem<Gender>>((Gender gender) {
                              return DropdownMenuItem<Gender>(
                                value: gender,
                                child: Text(
                                  gender.text.capitalizeFirstWord.get,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: gender == Gender.unselected
                                          ? AppColors.greyColor
                                          : (context.isDarkMode ? AppColors.whiteColor : AppColors.blackColor)),
                                ),
                              );
                            }).toList(),
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
                      label: AppText.email.capitalizeFirstWord.get,
                      onChanged: (value) {
                        BlocProvider.of<SignUpBloc>(context).add(EmailEvent(value));
                      }),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  TextFieldAuthentication(
                      icon: Icons.password,
                      label: AppText.password.capitalizeFirstWord.get,
                      isPassword: true,
                      onChanged: (value) {
                        BlocProvider.of<SignUpBloc>(context).add(PasswordEvent(value));
                      }),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  TextFieldAuthentication(
                      icon: Icons.password,
                      label: AppText.passwordConfirm.capitalizeEveryWord.get,
                      isPassword: true,
                      onChanged: (value) {
                        BlocProvider.of<SignUpBloc>(context).add(PasswordConfirmEvent(value));
                      }),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  /*
                  TextFieldPhoneNo(onChanged: (value) {
                    BlocProvider.of<SignUpBloc>(context).add(PhoneNoEvent(value));
                  }),
              */
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppText.signUpScreenAlreadyHaveAnAccount.capitalizeFirstWord.get,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: AppSizes.spaceBtwHorizontalFields,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(Screens.signInScreen, (route) => false),
                        child: Text(
                          AppText.signIn.capitalizeEveryWord.get,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.linkColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                  child: ButtonPrimary(
                text: AppText.commonNext.capitalizeFirstWord.get,
                loading: state is SignUpRequestLoadingState,
                onTap: verifyUser,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

