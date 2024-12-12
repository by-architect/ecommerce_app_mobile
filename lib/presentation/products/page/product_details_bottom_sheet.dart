import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/product_details_item.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final List<ProductDetailsItem> items;

  const ProductDetailsBottomSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.productDetailsPageDetails.capitalizeFirstWord.get,
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultPadding, horizontal: AppSizes.defaultPadding / 2),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: AppSizes.defaultPadding / 2),
                    child: Container(
                      decoration: AppStyles.defaultBoxDecoration.copyWith(border: Border.all(color: AppColors.greyColor)),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                                child: Center(
                              child: Text(
                                items[index].title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )),
                          ),
                          Expanded(
                            child: SizedBox(
                                child: Center(
                              child: Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    items[index].content,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16,color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
