import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';

class TextButtonDefault extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final TextStyle? textStyle;
  final Color? color;

  const TextButtonDefault({super.key, required this.onPressed, required this.text, this.textStyle, this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ??
            Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: color ?? Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
