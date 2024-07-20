import 'dart:async';

import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
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
import '../../../data/model/user.dart';
import '../widgets/verification_code_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late User globalUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    DialogUtil dialogUtil = DialogUtil(context) ;

    Future<void> verifyUser() async {

      UserService userService = UserServiceImpl();
      userService.sendEmailVerificationCode(FakeUserModels.admin.email);
/*      var userState = BlocProvider
          .of<UserBloc>(context)
          .state;
      var userValidation = UserValidation.validate(userState);

      if (userValidation.success) {
        globalUser = userState.toUser();

        BlocProvider.of<UserServiceBloc>(context).add(SendVerificationCodeEvent(globalUser.email));

        late StreamSubscription<UserServiceState> subscription;
        subscription = BlocProvider
            .of<UserServiceBloc>(context)
            .stream
            .listen((state) {
          Log.test("stream state", message: state.runtimeType.toString());
          switch (state) {
            case SendVerificationCodeSuccessState _:
              pageController.animateToPage(
                pageController.page!.toInt() + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              subscription.cancel();
            case SendVerificationCodeFailState failState:
              dialogUtil.toast(failState.error.userMessage);
              subscription.cancel();
          }
        });
      } else {
        dialogUtil.toast( userValidation.message);
      }*/
    }

    return Scaffold(
      appBar: const AppBarPopUp(
        text: AppText.signUp,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 100,
                    ),
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
                Positioned(
                  bottom: AppSizes.buttonBottomSpace,
                  child: BlocBuilder<UserServiceBloc, UserServiceState>(builder: (BuildContext context, UserServiceState state) {
                    return ButtonPrimary(
                      text: AppText.commonNext,
                      loading: state is SendVerificationCodeLoadingState,
                      onTap: verifyUser,
                    );
                  }),
                )
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}

//todo: on back pressed go to previous page view with controller or put back button

/*
                      pageController.animateToPage(
                        pageController.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
*/
