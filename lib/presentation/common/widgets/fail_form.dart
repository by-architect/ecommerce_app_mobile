import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FailForm extends StatelessWidget {
  final Fail fail;
  final Function() onRefreshTap;

  const FailForm({super.key, required this.fail, required this.onRefreshTap});

  @override
  Widget build(BuildContext context) {
    return switch (fail.exception) {
      NetworkDeviceDisconnectedException _ => _FailForm(fail: fail,image: AppImages.signalSearching,onTap: onRefreshTap,),
      Null _ || Object _ => _FailForm(fail: fail,image: AppImages.bugFixing,onTap: onRefreshTap,),
    };
  }
}

class _FailForm extends StatelessWidget {
  final Fail fail;
  final String image;
  final Function() onTap;
  const _FailForm({required this.fail, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FormInfoSkeleton(image: image, message: fail.userMessage, onTap: onTap, buttonText: AppText.refresh.capitalizeFirstWord.get);
  }
}
