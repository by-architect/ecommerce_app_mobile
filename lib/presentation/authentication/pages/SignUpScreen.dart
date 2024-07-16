
import 'package:ecommerce_app_mobile/common/helper/Log.dart';
import 'package:ecommerce_app_mobile/common/helper/resource.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldPhoneNo.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarDefault.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                      padding: const EdgeInsets.only(
                          right: AppSizes.spaceBtwHorizontalFields / 2),
                      child: TextFieldAuthentication(
                        label: AppText.name,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppSizes.spaceBtwHorizontalFields / 2),
                      child: TextFieldAuthentication(
                          label: AppText.surname, onChanged: (value) {}),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldAuthentication(
                  label: AppText.email, onChanged: (value) {}),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldAuthentication(
                  label: AppText.password, onChanged: (value) {}),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              const TextFieldPhoneNo(),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<UserServiceBloc, UserServiceState>(
                  builder: (BuildContext context, state) => switch (
                          BlocProvider.of<UserServiceBloc>(context)
                              .state
                              .userData
                              .status) {
                        Status.success => Text(BlocProvider.of<UserServiceBloc>(context).state.userData.data!.name),
                        Status.fail => Text(BlocProvider.of<UserServiceBloc>(context).state.userData.message ?? ""),
                        Status.loading => const Text("Loading"),
                      }),
              GestureDetector(
                  onTap: () {
                    Log.test("started");
                    BlocProvider.of<UserServiceBloc>(context)
                        .add(AddUser(FakeUserModels.test));
                  },
                  child: const ButtonPrimary(text: AppText.commonNext))
            ],
          ),
        ),
      ),
    );
  }
}
