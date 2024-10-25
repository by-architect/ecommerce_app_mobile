import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipDefault extends StatelessWidget {
  const ChipDefault({super.key, required this.label});

  final String label;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Chip(
        label: Text(Log.test(title: "label", data: label)!, ),
      ),
    );
  }
}
