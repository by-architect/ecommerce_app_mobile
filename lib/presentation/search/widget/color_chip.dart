import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry? padding;

  const ColorChip({super.key, required this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Chip(
        label: const SizedBox(),
        backgroundColor: color,
      )
      ,
    );
  }
}
