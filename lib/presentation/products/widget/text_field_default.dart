import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldDefault extends StatelessWidget {
  const TextFieldDefault({super.key,
    required this.onChanged,
    required this.labelOrHint,
    this.maxLines,
    this.maxLength,
    this.hintStyle,
    this.expands = false,
    this.enabled = true,
    this.isNumber = false,
    this.enableLabel = false,

    this.controller, this.inputFormatters});

  final Function(String text) onChanged;
  final String labelOrHint;
  final bool enableLabel;
  final TextStyle? hintStyle;
  final int? maxLines;
  final int? maxLength;
  final bool expands;
  final bool enabled;
  final bool isNumber;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.top,
      maxLines: maxLines,
      onChanged: onChanged,
      enabled: enabled,
      expands: expands,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: enableLabel ? null : labelOrHint,
        hintStyle: hintStyle ?? AppStyles.defaultHintStyle,
        labelText: enableLabel ? labelOrHint : null,
        counterText: "",
      ),
    );
  }
}
