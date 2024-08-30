import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/user.dart';
import '../../authentication/pages/email_verification_screen.dart';
import '../../common/widgets/text_button_default.dart';

class VerifyEmailCard extends StatelessWidget {
  final Function() onPressed;

  const VerifyEmailCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding * 1.5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
            gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
              AppColors.blueMaterialColor.shade500,
              AppColors.blueMaterialColor.shade400,
              AppColors.blueMaterialColor.shade300,
              AppColors.blueMaterialColor.shade300,
              AppColors.blueMaterialColor.shade400,
              AppColors.blueMaterialColor.shade500,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppText.profilePageVerifyEmailText.capitalizeFirstWord,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.whiteColor90),
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFields,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius)),
                      child: TextButtonDefault(
                          text: AppText.profilePageVerifyNow.capitalizeEveryWord,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          onPressed: onPressed),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SizedBox(
                      height: 100,
                      child: SvgPicture.asset(
                        AppImages.verifyEmail,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
