import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';

class AppBarPopUp extends StatefulWidget implements PreferredSizeWidget {
  final String text;

  const AppBarPopUp({super.key, required this.text});

  @override
  State<AppBarPopUp> createState() => _AppBarPopUpState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarPopUpState extends State<AppBarPopUp> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          height: 1.0,
          color: AppColors.grey,
        ),

      ),
      title: Center(child: Text(widget.text,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.hiddenBlack),)),
    );
  }
}
