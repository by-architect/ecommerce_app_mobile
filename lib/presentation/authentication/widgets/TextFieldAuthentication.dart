import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';

class TextFieldAuthentication extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? textEditingController;

  const TextFieldAuthentication({super.key, required this.label, required this.onChanged, this.isPassword = false, required this.icon, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(prefixIcon: Icon(icon),label: Text(label),),

    );
  }
}
