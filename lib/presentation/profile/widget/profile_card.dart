
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/widgets/network_image_with_loader.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    this.press,
    this.isShowArrow = true,
  });

  final String name, email, imageSrc;
  final bool   isShowArrow;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: CircleAvatar(
        radius: 28,
        child: NetworkImageWithLoader(
          imageSrc,
          radius: 100,
        ),
      ),
      title: Row(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: AppSizes.defaultPadding / 2),
/*
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultPadding / 2, vertical: AppSizes.defaultPadding / 4),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius:
                BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
              ),
              child: Text(
                proLableText,
                style: const TextStyle(
                  fontFamily: AppStyles.grandisExtendedFont,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.7,
                  height: 1,
                ),
              ),
            ),
*/
        ],
      ),
      subtitle: Text(email),
      trailing: isShowArrow
          ? SvgPicture.asset(
        AppImages.miniRightIcon,
        color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
      )
          : null,
    );
  }
}