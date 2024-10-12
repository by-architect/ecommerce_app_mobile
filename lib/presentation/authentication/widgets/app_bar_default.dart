import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/email_verification_screen.dart';
import 'package:ecommerce_app_mobile/presentation/search/page/search_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/user.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final User? user;
  final AllProductFeatures features;
  final Categories categories;

  const AppBarMain(
      {super.key, required this.features, required this.categories, this.user});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: const SizedBox(),
      titleSpacing: AppSizes.defaultPadding,
      leadingWidth: 0,
      centerTitle: false,
      title: Text(
        AppText.marketName.capitalizeEveryWord,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    categories: categories,
                    features: features,
                    user: user,
                  ),
                ));
          },
          icon: SvgPicture.asset(
            AppImages.searchIcon,
            height: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () {
            testScope(user);
            if (user != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailVerificationScreen(user: user!),
                  ));
            }
          },
          icon: SvgPicture.asset(
            AppImages.notificationIcon,
            height: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
          ),
        ),
      ],
      /*SvgPicture.asset(
    "assets/logo/Shoplon.svg",
    colorFilter: ColorFilter.mode(
    Theme.of(context).iconTheme.color!, BlendMode.srcIn),
    height: 20,
    width: 100,
    )*/
    );
  }
}

Future<void> testScope(User? user) async {
  UserService userService = UserServiceImpl();

  if (user == null) {
    Log.test(title: "change user password", message: "null user");
    return;
  }
  // final resource = await userService.changePassword(user, );
  // Log.test(resource: resource);

/*
  UserService userService = UserServiceImpl();
  if(FirebaseAuth.instance.currentUser == null) {
    final user = await userService.signIn(FakeUserModels.emin);
  Log.test(title: "user",message: user.status.toString());
  Log.test(title: "user",message: user.data.toString());
  }
*/

/*
  if (FirebaseAuth.instance.currentUser == null) {
    userService.signIn(FakeUserModels.emin);
  }
*/
}
