import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldDefault extends StatelessWidget {
  const TextFieldDefault(
      {super.key,
      required this.onChanged,
      required this.labelOrHint,
      this.maxLines,
      this.maxLength,
      this.hintStyle,
      this.enabled = true,
      this.enableLabel = false,
      this.controller});

  final Function(String) onChanged;
  final String labelOrHint;
  final bool enableLabel;
  final TextStyle? hintStyle;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      enabled: enabled,
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        hintText: enableLabel ? null : labelOrHint,
        hintStyle: hintStyle ?? AppStyles.defaultHintStyle,
        labelText: enableLabel ? labelOrHint : null,
        counterText: "",
      ),
    );
  }
}
