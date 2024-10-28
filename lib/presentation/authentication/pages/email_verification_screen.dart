import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/email_verification_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/email_verification_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/email_verification_state.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/user.dart';
import '../../../sddklibrary/util/Log.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User user;

  const EmailVerificationScreen({super.key, required this.user});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  static const maxCount = 60;
  int seconds = maxCount;
  Timer? timer;

  @override
  void initState() {
    BlocProvider.of<EmailVerificationBloc>(context).add(IsUserVerifiedEvent());
    BlocProvider.of<EmailVerificationBloc>(context).add(SendEmailVerificationEvent(widget.user));
    startTimer();

    final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      BlocProvider.of<EmailVerificationBloc>(context).add(IsUserVerifiedEvent());
    });

    late StreamSubscription<EmailVerificationState> subscription;

    subscription = BlocProvider.of<EmailVerificationBloc>(context).stream.listen((event) {
      final dialogUtil = DialogUtil(context);
      switch (event) {
        case EmailVerifiedState emailVerifiedState:
          BlocProvider.of<MainBlocs>(context).add(UserSignedInEvent(emailVerifiedState.user));
          dialogUtil.toast(AppText.verificationPageEmailVerifiedSuccessfully.capitalizeFirstWord.get);
          Navigator.of(context).pop();
          timer.cancel();
          subscription.cancel();
          break;
        case EmailVerificationFailState failState || EmailVerificationFailState failState:
          dialogUtil.info(AppText.errorEmailNotVerified.capitalizeEveryWord.get, failState.fail.userMessage);
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
        //todo: appbar to verification screen
        appBar: AppBarPopBack(
          title: AppText.verificationEmail.capitalizeEveryWord.get,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 0,
                  child: Column(
                    children: [
                      Text(AppText.verificationPageCheckYourEmail.capitalizeFirstWord.get,
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(
                        height: AppSizes.spaceBtwVerticalFields,
                      ),
                      Text(
                        AppText.verificationPageEmailBody.capitalizeFirstWord.get,
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
                    child: SvgPicture.asset(
                      AppImages.openedEmail,
                      colorFilter: ColorFilters.pinkToPrimaryColor(context),
                    ),
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
                            child: seconds == 0
                                ? ButtonPrimary(
                                    text: seconds == 0
                                        ? AppText.verificationPageSendEmailAgain.capitalizeFirstWord.get
                                        : seconds.toString(),
                                    onTap: () {
                                      if (seconds == 0) {
                                        startTimer();
                                        BlocProvider.of<EmailVerificationBloc>(context)
                                            .add(SendEmailVerificationEvent(widget.user));
                                      }
                                    },
                                  )
                                : ButtonSecondary(
                                    text: seconds == 0
                                        ? AppText.verificationPageSendEmailAgain.capitalizeFirstWord.get
                                        : seconds.toString(),
                                    onTap: () {
                                      if (seconds == 0) {
                                        startTimer();
                                        BlocProvider.of<EmailVerificationBloc>(context)
                                            .add(SendEmailVerificationEvent(widget.user));
                                      }
                                    },
                                  ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
