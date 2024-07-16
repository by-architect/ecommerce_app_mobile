import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';
class TextFieldAuthentication extends StatefulWidget {
  final String label;
  final Function(String) onChanged;
  const TextFieldAuthentication({super.key, required this.label, required this.onChanged});


  @override
  State<TextFieldAuthentication> createState() => _TextFieldAuthenticationState();
}

class _TextFieldAuthenticationState extends State<TextFieldAuthentication> {
  @override
  Widget build(BuildContext context) {
    return
      TextField(
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,

          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  AppColors.hiddenGrey,
              // Change this to your desired color
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:Theme.of(context).primaryColorDark,
              // Change this to your desired color
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      );

  }
}
