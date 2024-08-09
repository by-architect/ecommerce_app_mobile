import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/UIHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/constant/gender.dart';
import '../../../common/ui/theme/AppStyles.dart';

class DropdownDefault<T> extends StatelessWidget {
  final T value;
  final String hint;
  final Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  const DropdownDefault({super.key,required this.value, required this.hint, required this.onChanged, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: AppStyles.defaultBoxDecoration,
      child: DropdownButton<T>(
        underline: const SizedBox.shrink(),
        dropdownColor: context.isDarkMode ? AppColors.blackColor: AppColors.whiteColor,
       borderRadius:BorderRadius.circular(AppSizes.defaultBorderRadius) ,
        value:value,
        hint:Text(hint),
        onChanged: onChanged,
      items: items,
      ),
    );
  }
}

