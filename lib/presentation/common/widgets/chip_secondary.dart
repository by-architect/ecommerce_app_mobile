import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipSecondary extends StatelessWidget {
  const ChipSecondary({super.key, required this.label});

  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label),side: const BorderSide(width: 0,color: Colors.transparent),backgroundColor: AppColors.whiteColor90,);
  }
}
