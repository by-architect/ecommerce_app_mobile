import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final bool primaryDecoration;
  final bool loading; // New loading variable

  const ButtonPrimary({
    required this.text,
    this.primaryDecoration = true,
    this.loading = false, // Default value for loading
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: primaryDecoration
          ? BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      )
          : BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: loading // Check if loading is true
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              primaryDecoration ? Colors.white : Colors.black),
        )
            : Text(
          text,
          style: TextStyle(
              color: primaryDecoration
                  ? Colors.white
                  : Colors.black.withOpacity(0.7)),
        ),
      ),
    );
  }
}
