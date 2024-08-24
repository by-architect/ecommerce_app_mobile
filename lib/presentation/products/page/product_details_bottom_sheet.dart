import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '../../../data/model/product_details_item.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final List<ProductDetailsItem> items;

  const ProductDetailsBottomSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPopBack(
        title: AppText.productDetailsPageDetails,
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                          decoration: BoxDecoration(border: Border.all(width: 0.7,color: AppColors.blackColor)),
                          child: Center(
                            child: Text(
                              items[index].title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Container(
                          height: 48,
                          decoration: BoxDecoration(border: Border.all(width: 0.7,color: AppColors.blackColor)),
                          child: Center(
                            child: Text(
                              items[index].content,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
