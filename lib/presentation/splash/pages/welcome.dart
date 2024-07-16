import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constant/Screens.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              children: [
                _Page(
                    title: AppText.welcomePageOneTitle,
                    content: AppText.welcomePageOneContent,
                    image: AppImages.shoppingBags,
                    buttonOneText: AppText.commonNext,
                    onButtonOneTap: () {
                      pageController.animateToPage(
                        pageController.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }),
                _Page(
                    title: AppText.welcomePageTwoTitle,
                    content: AppText.welcomePageTwoContent,
                    image: AppImages.windowShopping,
                    buttonOneText: AppText.commonNext,
                    onButtonOneTap: () {
                      pageController.animateToPage(
                        pageController.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }),
                _Page(
                  title: AppText.welcomePageThreeTitle,
                  content: AppText.welcomePageThreeContent,
                  image: AppImages.signIn,
                  buttonOneText: AppText.signIn,
                  buttonTwoText: AppText.signUp,
                  onButtonOneTap: () {
                    Navigator.of(context).pushNamed(Screens.signInScreen);
/*
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("loginScreen", (route) => false);
*/
                  },
                  onButtonTwoTap: () {
                    Navigator.of(context).pushNamed(Screens.signUpScreen);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
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
        Text(title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium),
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
}
