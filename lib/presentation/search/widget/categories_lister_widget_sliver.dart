import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/categories.dart';
import '../../../data/model/category.dart';
import '../../../data/model/category_struct.dart';
import '../../products/widget/product_list_tile.dart';

class CategoriesListerWidgetSliver extends StatefulWidget {
  final Categories categories;
  final Function(Category category) onLastItemPressed;
  const CategoriesListerWidgetSliver({
    super.key,
    required this.categories,
    required this.onLastItemPressed
  });

  @override
  State<CategoriesListerWidgetSliver> createState() => _CategoriesListerWidgetSliverState();
}

class _CategoriesListerWidgetSliverState extends State<CategoriesListerWidgetSliver> {
  late CategoryStruct currentCategoryStruct;

  @override
  void initState() {
    currentCategoryStruct = CategoryStruct(widget.categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Return a list of slivers that can be used in a CustomScrollView
    return SliverList(
      delegate: SliverChildListDelegate([
        // Header section
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
                vertical: AppSizes.defaultPadding / 2
            ),
            child: Row(
              children: [
                currentCategoryStruct.isFirstLayer
                    ? const Flexible(flex: 1, child: SizedBox())
                    : Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentCategoryStruct.previousLayer();
                          });
                        },
                        child: const Icon(Icons.arrow_back)
                    ),
                  ),
                ),
                Text(
                  currentCategoryStruct.isFirstLayer
                      ? AppText.commonPageCategories.capitalizeFirstWord.get
                      : "${AppText.commonPageCategories} > ${currentCategoryStruct.title}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ],
            ),
          ),
        ),

        // Spacing
        const SizedBox(
          height: AppSizes.spaceBtwVerticalFields,
        ),

        // List items
        ...List.generate(
          currentCategoryStruct.currentLayer.length,
              (index) => ProductListTile(
            title: currentCategoryStruct.currentLayer[index].name,
            isShowBottomBorder: currentCategoryStruct.currentLayer[index].id ==
                currentCategoryStruct.currentLayer.last.id,
            press: () {
              if (currentCategoryStruct.isLastLayer(
                  currentCategoryStruct.currentLayer[index])) {
                widget.onLastItemPressed(currentCategoryStruct.currentLayer[index]);
              } else {
                setState(() {
                  currentCategoryStruct.nextLayer(
                      currentCategoryStruct.currentLayer[index]);
                });
              }
            },
          ),
        ),
      ]),
    );
  }
}