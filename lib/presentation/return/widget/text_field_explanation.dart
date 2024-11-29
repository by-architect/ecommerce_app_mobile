import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';

class TextFieldExplanation extends StatelessWidget {
  const TextFieldExplanation({
    super.key,
    this.onChanged,
    this.controller,
    this.maxLength,
    this.hint,
  });

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int? maxLength;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyles.defaultHintStyle,
        border: AppStyles.outlineInputBorder,
        enabledBorder: AppStyles.outlineInputBorder,
        focusedBorder: AppStyles.focusedOutlineInputBorder,
      ),
      maxLength: maxLength,
      maxLines: null,
      expands: true,
    );
  }
}
