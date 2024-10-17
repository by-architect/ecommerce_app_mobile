import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';

class TextMarket extends StatelessWidget {
  const TextMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        AppText.marketName.capitalizeEveryWord.get,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      );
  }
}
