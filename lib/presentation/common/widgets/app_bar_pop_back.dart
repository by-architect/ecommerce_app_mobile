import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';

class AppBarPopBack extends StatefulWidget implements PreferredSizeWidget {
  const AppBarPopBack({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<AppBarPopBack> createState() => _AppBarPopBackState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarPopBackState extends State<AppBarPopBack> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: const Padding(
        padding: EdgeInsets.only(left: AppSizes.defaultPadding, top: AppSizes.defaultPadding),
        child: BackButton(),
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: AppSizes.defaultPadding),
        child: Text(
          widget.title ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
