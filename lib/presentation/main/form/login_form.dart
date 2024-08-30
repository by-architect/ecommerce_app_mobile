import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:flutter/cupertino.dart';

class LoginForm extends StatelessWidget {
  final String message;
  final String image;
  const LoginForm({super.key, required this.message, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: FormInfoSkeleton(image: image, buttonText: AppText.signIn.capitalizeEveryWord, message: message, onTap: () {

        },),
      ),
    );
  }
}
