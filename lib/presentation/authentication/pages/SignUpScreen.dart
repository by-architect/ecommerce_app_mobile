import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_state.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldPhoneNo.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarDefault.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/viewmodel/user/user_service_event.dart';
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
/*
    BlocProvider.of<UserServiceBloc>(context).stream.listen(
      (event) {
        Log.test(event.userData.status.name);
        switch (event.userData.status) {
          case Status.success:
          case Status.fail:
          // TODO: Handle this case.
          case Status.loading:
          // TODO: Handle this case.
          case Status.stable:
          // TODO: Handle this case.
        }
      },
    );
*/
  }

  @override
  Widget build(BuildContext context) {
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
                  label: AppText.email,
                  onChanged: (value) {
                    BlocProvider.of<UserBloc>(context).add(EmailEvent(value));
                  }),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldAuthentication(
                  label: AppText.password,
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
              BlocBuilder<UserBloc, UserState>(
                builder: (BuildContext context, UserState state) => Text(BlocProvider.of<UserBloc>(context).state.phoneNo),
              ),
/*
              BlocBuilder<UserServiceBloc, UserServiceState>(
                  builder: (BuildContext context, state) => switch (BlocProvider.of<UserServiceBloc>(context).state.userData.status) {
                        Status.success => Text(BlocProvider.of<UserServiceBloc>(context).state.userData.data!.name),
                        Status.fail => Text(BlocProvider.of<UserServiceBloc>(context).state.userData.message ?? ""),
                        Status.loading => const Text("Loading"),
                        Status.stable => const Text("Start Doing something")
                      }),
*/
              GestureDetector(
                  onTap: () {
                    var userState = BlocProvider.of<UserBloc>(context).state;
                    var userValidation = UserValidation.validate(userState);
                    // BlocProvider.of<UserServiceBloc>(context).add(AddUserEvent(FakeUserModels.admin));
                    if (userValidation.success) {
                      BlocProvider.of<UserServiceBloc>(context).add(AddUserEvent(userState.toUser()));
                    } else {
                      DialogUtil.toast(context, userValidation.message);
                    }
                  },
                  child: BlocBuilder<UserServiceBloc, UserServiceState>(
                      builder: (BuildContext context, UserServiceState state) =>
                          switch (BlocProvider.of<UserServiceBloc>(context).state.userData.status) {
                            Status.success => const ButtonPrimary(
                                text: AppText.commonNext,
                                loading: false,
                              ),
                            Status.fail => const ButtonPrimary(
                                text: AppText.commonNext,
                                loading: false,
                              ),
                            Status.loading => const ButtonPrimary(
                                text: AppText.commonNext,
                                loading: true,
                              ),
                            Status.stable => const ButtonPrimary(
                                text: AppText.commonNext,
                                loading: false,
                              )
                          }))
            ],
          ),
        ),
      ),
    );
  }
}
