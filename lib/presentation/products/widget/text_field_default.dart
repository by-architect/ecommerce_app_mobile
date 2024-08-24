import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldDefault extends StatelessWidget {
  const TextFieldDefault({super.key, required this.onChanged, required this.hint, this.maxLines, this.maxLength});

  final Function(String) onChanged;
  final String hint;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      maxLength: maxLength,

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.greyColor, fontWeight: FontWeight.w500, fontSize: 18,),
      ),
    );
  }
}
