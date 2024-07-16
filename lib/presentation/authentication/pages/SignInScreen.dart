import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarDefault.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDefault(
        text: AppText.signIn,
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(height: AppSizes.defaultSpace,),
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
                    label: AppText.email,
                    onChanged: (value){},
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwVerticalFields,
                  ),
                  TextFieldAuthentication(
                    label: AppText.password,
                    onChanged: (value){},
                  ),
                ],
              )),
              const Positioned(
                  bottom: AppSizes.buttonBottomSpace,
                  child: ButtonPrimary(text: AppText.signIn)),
            ],
          )),
    );
  }
}
