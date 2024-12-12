import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category_struct.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/chip_default.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/chip_primary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/chip_right_arrow.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/chip_secondary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/category.dart';
import '../../products/widget/product_list_tile.dart';

class CategoriesListerWidget extends StatefulWidget {
  final Categories categories;
  final Function(Category category) onLastItemPressed;

  const CategoriesListerWidget({super.key, required this.onLastItemPressed, required this.categories});

  @override
  State<CategoriesListerWidget> createState() => _CategoriesListerWidgetState();
}

class _CategoriesListerWidgetState extends State<CategoriesListerWidget> {
  late CategoryStruct currentCategoryStruct;

  @override
  void initState() {
    currentCategoryStruct = CategoryStruct(widget.categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppText.commonPageCategories.capitalizeFirstWord.get,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwVerticalFields),
        Row(
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
                          colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
            Wrap(
              children: [
                ...List.generate(currentCategoryStruct.categoryNode.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFieldsSmall, ),
                    child: ChipRightArrow(label: currentCategoryStruct.categoryNode.node[index].name),
                  );
                }),
              ],
            )
          ],
          /*
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
                          child: const Icon(Icons.arrow_back)),
                    ),
                  ),
            Text(
              currentCategoryStruct.isFirstLayer
                  ? AppText.commonPageCategories.capitalizeFirstWord.get
                  : "${AppText.commonPageCategories} > ${currentCategoryStruct.title}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
                */
        ),
        const SizedBox(
          height: AppSizes.spaceBtwVerticalFields,
        ),
        Flexible(
          child: ListView.builder(
            itemCount: currentCategoryStruct.currentLayer.length,
            itemBuilder: (context, index) => ProductListTile(
              title: currentCategoryStruct.currentLayer[index].name,
              textStyle: currentCategoryStruct.isLastLayer(currentCategoryStruct.currentLayer[index])
                  ? null
                  : Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
        ),
      ],
    );
  }
}
