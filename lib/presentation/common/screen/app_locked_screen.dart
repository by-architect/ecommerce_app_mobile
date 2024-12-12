import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';

class AppLockedScreen extends StatelessWidget {
  const AppLockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: FormInfoSkeleton(
          image: context.isDarkMode
              ? AppImages.serverErrorDark
              : AppImages.serverError,
          message: AppText
              .infoAppIsGettingReadyPageAppIsGettingReady.capitalizeFirstWord.get,
          notSvg: true,
        ),
      ),
    );
  }
}
