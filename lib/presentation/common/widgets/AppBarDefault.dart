import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';

class AppBarDefault extends StatefulWidget implements PreferredSizeWidget {
  final String text;

  const AppBarDefault({super.key, required this.text});

  @override
  State<AppBarDefault> createState() => _AppBarDefaultState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarDefaultState extends State<AppBarDefault> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
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
