import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../sddklibrary/util/Log.dart';

class ChipPrimary extends StatelessWidget {

  const ChipPrimary({super.key, required this.label});
  final String label;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Chip(
        label: Text(label,),
        backgroundColor: Theme.of(context).primaryColor.asMaterialColor.shade100,
      ),
    );
  }
}
