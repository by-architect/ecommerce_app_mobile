import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/presentation/search/page/search_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/fakerepository/fake_models.dart';
import '../../../data/model/user.dart';
import '../../../data/service/impl/user_service_impl.dart';
import '../../../data/service/user_service.dart';
import '../../search/bloc/search_bloc.dart';
import '../../search/bloc/search_event.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final ProductFeatures features;
  const AppBarMain({super.key, required this.features});

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
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(outContext: context, features: features),));
          },
          icon: SvgPicture.asset(
            AppImages.searchIcon,
            height: 24,
            colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () {
            testScope();
            // Navigator.pushNamed(context, Screens.notificationScreen);
          },
          icon: SvgPicture.asset(
            AppImages.notificationIcon,
            height: 24,
            colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
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

Future<void> testScope() async {
  //todo: test scope
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
