import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category_struct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/category.dart';
import '../../products/widget/product_list_tile.dart';

class CategoriesListerWidget extends StatefulWidget {
  final Categories categories;
  final Function(Category category) onLastItemPressed;

  const CategoriesListerWidget({super.key,  required this.onLastItemPressed, required this.categories});

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
        SizedBox(
          height: 60,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
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
            ),
          ),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwVerticalFields,
        ),
        Flexible(
          child: ListView.builder(
            itemCount: currentCategoryStruct.currentLayer.length,
            itemBuilder: (context, index) => ProductListTile(
              title: currentCategoryStruct.currentLayer[index].name,
              isShowBottomBorder:
                  currentCategoryStruct.currentLayer[index].id == currentCategoryStruct.currentLayer.last.id,
              press: () {
                if (currentCategoryStruct.isLastLayer(currentCategoryStruct.currentLayer[index])) {
                  widget.onLastItemPressed(currentCategoryStruct.currentLayer[index]);
                  /*
                        BlocProvider.of<SearchBloc>(context)
                            .add(
                            SelectedCategoriesEvent([currentCategoryStruct.currentLayer[index]])
                        );
                        BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(
                                  user: widget.user,
                                  features: widget.features,
                                  categories: currentCategories,
                                )));
          */
                } else {
                  setState(() {
                    currentCategoryStruct.nextLayer(currentCategoryStruct.currentLayer[index]);
                  });
                  /*
                        BlocProvider.of<DiscoverBloc>(context)
                            .add(NextCategoryLayerEvent(currentCategoryStruct.currentLayer[index]));
          */
                }
                /*
                            if (state.selectedCategory != null) {
                            }
                      */
              },
            ),
          ),
        ),
      ],
    );
  }
}
