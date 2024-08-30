import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/AppText.dart';
import 'button_secondary.dart';

class FormInfoSkeleton extends StatelessWidget {
  final String image;
  final String message;
  final String buttonText;
  final Function() onTap;

  const FormInfoSkeleton(
      {super.key,
      required this.image,
      required this.message,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex: 5, child: SvgPicture.asset(image)),
        Flexible(
            flex: 1,
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        Flexible(
            flex: 1,
            child: ButtonSecondary(
              text: buttonText,
              onTap: onTap,
            ))
      ],
    );
  }
}
