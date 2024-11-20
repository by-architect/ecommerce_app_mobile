import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/order/widget/order_process_widget.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(title: AppText.returnPageReturn.capitalizeEveryWord.get),
      body: const Column(
        children: [
        ],
      ),
    );
  }
}
