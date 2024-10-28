import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/color_filters.dart';
import 'network_image_with_loader.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key, this.imageSrc, required this.radius});

  final String? imageSrc;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return
      CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: radius,
        child: imageSrc == null || imageSrc!.isEmpty
            ? SvgPicture.asset(
          AppImages.profileIcon,
          colorFilter: ColorFilters.primaryIconColorFilter(context),
        )
            : NetworkImageWithLoader(
          imageSrc!,
          radius: 100,
        ),
      );
  }
}
