import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTileSelectable extends StatelessWidget {
  const ListTileSelectable({super.key, required this.title, required this.onTap, this.leading, this.trailing});

  final Widget title;
  final Function() onTap;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: leading,
        onTap: onTap,
        title: title,
        trailing:trailing
    );
  }
}
