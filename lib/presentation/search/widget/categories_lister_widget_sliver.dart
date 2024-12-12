import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/categories.dart';
import '../../../data/model/category.dart';
import '../../../data/model/category_struct.dart';
import '../../../sddklibrary/ui/widget_clickable_outlined.dart';
import '../../common/widgets/chip_right_arrow.dart';
import '../../products/widget/product_list_tile.dart';

class CategoriesListerWidgetSliver extends StatefulWidget {
  final Categories categories;
  final Function(Category category) onLastItemPressed;

  const CategoriesListerWidgetSliver({super.key, required this.categories, required this.onLastItemPressed});

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
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
          child: Row(
            children: [
              currentCategoryStruct.isFirstLayer
                  ? const SizedBox.shrink()
                  : Flexible(
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: ClickableWidgetOutlined(
                          onPressed: () {
                            setState(() {
                              currentCategoryStruct.previousLayer();
                            });
                          },
                          child: SvgPicture.asset(
                            AppImages.arrowLeft,
                            height: 24,
                            colorFilter: ColorFilters.oneColorForIcon(AppColors.blackColor),
                          ),
                        ),
                      ),
                    ),
              Wrap(
                children: [
                  ...List.generate(currentCategoryStruct.categoryNode.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: AppSizes.spaceBtwHorizontalFieldsSmall,
                      ),
                      child: ChipRightArrow(label: currentCategoryStruct.categoryNode.node[index].name),
                    );
                  }),
                ],
              )
            ],
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
            isShowBottomBorder: currentCategoryStruct.currentLayer[index].id == currentCategoryStruct.currentLayer.last.id,
            press: () {
              if (currentCategoryStruct.isLastLayer(currentCategoryStruct.currentLayer[index])) {
                widget.onLastItemPressed(currentCategoryStruct.currentLayer[index]);
              } else {
                setState(() {
                  currentCategoryStruct.nextLayer(currentCategoryStruct.currentLayer[index]);
                });
              }
            },
          ),
        ),
      ]),
    );
  }
}
