import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';

class TextFieldAuthentication extends StatefulWidget {
  final String label;
  final Function(String) onChanged;
  final IconData icon;
  final bool isPassword;

  const TextFieldAuthentication({super.key, required this.label, required this.onChanged, this.isPassword = false, required this.icon});

  @override
  State<TextFieldAuthentication> createState() => _TextFieldAuthenticationState();
}

class _TextFieldAuthenticationState extends State<TextFieldAuthentication> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword,
      onChanged: widget.onChanged,
      decoration: AppStyles.defaultInputDecoration(context, widget.icon, widget.label),

    );
  }
}
