import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FailSkeleton extends StatelessWidget {
  final Fail fail;
  final Function() onRefreshTap;

  const FailSkeleton({super.key, required this.fail, required this.onRefreshTap});

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex:5,child: SvgPicture.asset(image)),
        Flexible(flex:1,child: Text(fail.userMessage,style: Theme.of(context).textTheme.titleMedium,)),
        Flexible(flex: 1,child: ButtonPrimary(text: AppText.refresh,primaryDecoration: false,onTap: onTap,))
      ],
    );
  }
}
