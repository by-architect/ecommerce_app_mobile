import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldPhoneNo.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarDefault.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/network_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/viewmodel/user/user_service_event.dart';
import '../../../sddklibrary/helper/Log.dart';
import '../../../sddklibrary/helper/resource.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserServiceBloc>(context).stream.listen(
      (event) {
        // Log.test(event.userData.status.name,message: event.userData.message ?? "");
        switch (event.userData.status) {
          case Status.success:
            Navigator.of(context).pushNamed(Screens.verificationScreen);
          case Status.fail:
            DialogUtil.toast(context, event.userData.message ?? "");
          case Status.loading:
          case Status.stable:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> saveUser() async {

      var userState = BlocProvider.of<UserBloc>(context).state;
      var userValidation = UserValidation.validate(userState);

      if (userValidation.success) {
        BlocProvider.of<UserServiceBloc>(context).add(AddUserEvent(userState.toUser()));
      } else {
        DialogUtil.toast(context, userValidation.message);
      }
    }

    return Scaffold(
      appBar: const AppBarDefault(
        text: AppText.signUp,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
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
/*
              BlocBuilder<UserBloc, UserState>(
                builder: (BuildContext context, UserState state) => Text(BlocProvider.of<UserBloc>(context).state.phoneNo),
              ),
*/
/*
              BlocBuilder<UserServiceBloc, UserServiceState>(
                  builder: (BuildContext context, state) => switch (BlocProvider.of<UserServiceBloc>(context).state.userData.status) {
                        Status.success => Text(BlocProvider.of<UserServiceBloc>(context).state.userData.data!.name),
                        Status.fail => Text(BlocProvider.of<UserServiceBloc>(context).state.userData.message ?? ""),
                        Status.loading => const Text("Loading"),
                        Status.stable => const Text("Start Doing something")
                      }),
*/
              BlocBuilder<UserServiceBloc, UserServiceState>(
                  builder: (BuildContext context, UserServiceState state) =>
                      switch (BlocProvider.of<UserServiceBloc>(context).state.userData.status) {
                        Status.success => ButtonPrimary(
                            text: AppText.commonNext,
                            loading: false,
                          onTap: saveUser,
                          ),
                        Status.fail => ButtonPrimary(
                            onTap: saveUser,
                            text: AppText.commonNext,
                            loading: false,
                          ),
                        Status.loading => const ButtonPrimary(
                            text: AppText.commonNext,
                            loading: true,
                          ),
                        Status.stable => ButtonPrimary(
                            text: AppText.commonNext,
                            loading: false,
                            onTap: saveUser,
                          )
                      })
            ],
          ),
        ),
      ),
    );
  }
}
