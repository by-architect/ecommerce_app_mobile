import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';

class TextFieldPhoneNo extends StatefulWidget {
  final Function(String) onChanged;
  final bool hasStar;
  final TextEditingController? controller;

  const TextFieldPhoneNo({super.key, required this.onChanged,  this.hasStar = false, this.controller});

  @override
  State<TextFieldPhoneNo> createState() => _TextFieldPhoneNoState();
}

class _TextFieldPhoneNoState extends State<TextFieldPhoneNo> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: widget.controller,
      onChanged: widget.onChanged,
      autocorrect: false,
      inputFormatters: [
        MaskedInputFormatter(
          '(###) ###-####',
        )
      ],
      decoration: InputDecoration(
        hintText:
            widget.hasStar ? AppText.commonPagePhoneNoHintText.addStar.get : AppText.commonPagePhoneNoHintText.get,
        hintStyle: AppStyles.defaultHintStyle,
        prefixIcon: const Icon(Icons.phone),
        prefixIconColor: AppColors.greyColor,
        border: AppStyles.outlineInputBorder,
        enabledBorder: AppStyles.outlineInputBorder,
        focusedBorder: AppStyles.focusedOutlineInputBorder,
      ),
      validator: (value) {
        //todo: validate
        return null;
      },
    );
  }
}
