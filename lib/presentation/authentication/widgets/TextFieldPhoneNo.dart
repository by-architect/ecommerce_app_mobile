import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';

class TextFieldPhoneNo extends StatefulWidget {
   final Function(String) onChanged;
  const TextFieldPhoneNo({super.key, required this.onChanged});

  @override
  State<TextFieldPhoneNo> createState() => _TextFieldPhoneNoState();
}

class _TextFieldPhoneNoState extends State<TextFieldPhoneNo> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onChanged: widget.onChanged,
      autocorrect: false,
      inputFormatters: [
        MaskedInputFormatter(
          '(###) ###-####',
        )
      ],
      decoration: InputDecoration(
        hintText: "(555) 555 55 55",
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        prefixIcon: const Icon(Icons.phone),
        prefixIconColor: AppColors.hiddenGrey,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.hiddenGrey,
            // Change this to your desired color
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorDark,
            // Change this to your desired color
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
/*
      decoration: InputDecoration(
        hintText: "(555) 555 55 55",
        hintStyle:TextStyle(color: AppColors.grey),
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.defaultCornerRadius)),
      ),
*/

      validator: (value) {
        //todo: validate
        return null;
      },
    );
  }
}
