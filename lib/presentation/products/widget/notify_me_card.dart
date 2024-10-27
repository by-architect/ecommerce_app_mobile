import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppTheme.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotifyMeCard extends StatelessWidget {
  const NotifyMeCard({
    super.key,
    this.isNotify = false,
    required this.onChanged,
  });

  final bool isNotify;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
            color: isNotify ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.defaultBorderRadius),
            ),
            border: Border.all(
              color: isNotify ? Colors.transparent : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: Colors.white10),
                    ),
                    child: SvgPicture.asset(
                      AppImages.notificationIcon,
                      //todo: set color filter to colorfilters
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.defaultPadding),
                Expanded(
                  child: Text(
                    AppText.productPageNotifyMe.capitalizeEveryWord.get,
                    style: TextStyle(
                        color: isNotify ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                CupertinoSwitch(
                    onChanged: onChanged,
                    value: isNotify,
                    activeColor: Theme.of(context).primaryColor.asMaterialColor.shade900)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
