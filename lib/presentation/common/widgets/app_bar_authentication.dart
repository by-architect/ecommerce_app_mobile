import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';

class AppBarAuthentication extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppBarAuthentication({super.key, required this.title});

  @override
  State<AppBarAuthentication> createState() => _AppBarAuthenticationState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarAuthenticationState extends State<AppBarAuthentication> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
         preferredSize: const Size.fromHeight(1.0),
        child: Container(
          height: 1.0,
            color: AppColors.greyColor,
        ),

      ),
      title: Center(child: Text(widget.title,style: Theme.of(context).textTheme.titleLarge)),
    );
  }
}
