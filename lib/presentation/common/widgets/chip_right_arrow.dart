import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppColors.dart';

class ChipRightArrow extends StatelessWidget {
  const ChipRightArrow({super.key, required this.label, });

  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label),shape: AppStyles.rightArrowOutlinedBorder.copyWith(side: const BorderSide(color: Colors.black)),);
  }
}
