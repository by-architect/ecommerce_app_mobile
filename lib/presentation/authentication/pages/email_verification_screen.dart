import 'dart:async';

import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/user/user_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/AppBarPopUp.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/user.dart';
import '../../../data/viewmodel/user/user_service_bloc.dart';
import '../../../data/viewmodel/user/user_service_event.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User user;
  const EmailVerificationScreen({super.key, required this.user});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  User? user;
  static const maxCount = 60;
  int seconds = maxCount;
  Timer? timer;

  @override
  void initState() {
    startTimer();

    final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      BlocProvider.of<UserServiceBloc>(context).add(IsUserVerifiedEvent());
    });

    late StreamSubscription<UserServiceState> subscription;

    subscription = BlocProvider.of<UserServiceBloc>(context).stream.listen((event) {
      switch (event) {
        case EmailVerifiedState _:
          DialogUtil(context).toast(AppText.accountCreatedSuccessfully);
          Navigator.of(context).pushNamedAndRemoveUntil(
            Screens.homeScreen,
            (route) => false,
          );
          timer.cancel();
          subscription.cancel();
        case UserServiceSuccessState userServiceSuccessState:
          user = userServiceSuccessState.user;
          break;
      }
    });
    super.initState();
  }

  void startTimer() {
    seconds = maxCount;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      seconds = maxCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarPopUp(
          text: AppText.verificationEmail,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 0,
                child: Column(
                  children: [
                    Text(AppText.verificationPageCheckYourEmail,
                        textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFields,
                    ),
                    Text(
                      AppText.verificationPageEmailBody,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset(AppImages.openedEmail),
                ),
              ),
              Flexible(
                flex: 0,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.spaceBtwHorizontalFields / 2),
                          child: ButtonPrimary(
                            text: seconds == 0 ? AppText.verificationPageSendEmailAgain : seconds.toString(),
                            primaryDecoration: seconds == 0,
                            onTap: () {
                              if (seconds == 0) {
                                startTimer();
                                 BlocProvider.of<UserServiceBloc>(context).add(SendVerificationEmailEvent(widget.user));
                              }
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
