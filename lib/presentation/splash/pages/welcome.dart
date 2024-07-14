import 'package:ecommerce_app_mobile/common/helper/Log.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_states.dart';
import 'package:ecommerce_app_mobile/presentation/splash/widgets/ButtonSplash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Stack(
          children: [
            PageView(
              children: [
                _Page(
                    title: AppText.welcomePageOneTitle,
                    content: AppText.welcomePageOneContent,
                    image: AppImages.shoppingBags,
                    buttonText: AppText.commonNext,
                    onPressed: () {
                      BlocProvider.of<MainBlocs>(context)
                          .add(ToggleTheme(context));
                    }),
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
  final String buttonText;
  final Function() onPressed;

  const _Page({
    required this.title,
    required this.content,
    required this.image,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset(image),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 100.0,
                ),
                GestureDetector(
                    onTap: onPressed,
                    child: ButtonSplash(
                      text: buttonText,
                    )),
              ],
            );
  }
}
