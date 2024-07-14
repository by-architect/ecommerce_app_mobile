import 'package:flutter/material.dart';

class ButtonSplash extends StatelessWidget {
  final String text;

  const ButtonSplash({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(text,style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
      ),
    );
  }
}
