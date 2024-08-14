import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';

class TextButtonDefault extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const TextButtonDefault({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme
            .of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Theme
            .of(context)
            .primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
