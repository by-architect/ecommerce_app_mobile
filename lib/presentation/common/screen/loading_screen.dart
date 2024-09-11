import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
          width: 200,
          child: Lottie.asset(AppImages.restaurantOpenLottie)),
    );
  }
}
