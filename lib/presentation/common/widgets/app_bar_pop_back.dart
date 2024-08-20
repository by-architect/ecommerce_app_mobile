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
  });

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
      leading: const SizedBox(),
      leadingWidth: 0,
      centerTitle: false,
      title: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
