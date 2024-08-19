/*
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_event.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_state.dart';
import 'package:ecommerce_app_mobile/presentation/discover/widget/discover_skelton.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppText.dart';
import '../../../data/model/category.dart';

class ExpansionCategory extends StatefulWidget {
  final List<List<Category>> categoriesByLayer;

  const ExpansionCategory({
    super.key,
    required this.categoriesByLayer,
  });

  @override
  State<ExpansionCategory> createState() => _ExpansionCategoryState();
}

class _ExpansionCategoryState extends State<ExpansionCategory> {
  @override
  void initState() {
    BlocProvider.of<DiscoverBloc>(context).add(LoadCategoriesEvent(widget.categoriesByLayer.first, widget.categoriesByLayer.length));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (BuildContext context, state) => switch (state) {
              CategoryLoadingState _ => const DiscoverCategoriesSkelton(),
              CategorySuccessState _ => Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace, vertical: AppSizes.defaultSpace / 2),
                        child: Row(
                          children: [
                            state.categoryNode.isEmpty
                                ? const Flexible(flex: 1, child: SizedBox())
                                : Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<DiscoverBloc>(context).add(PreviousCategoryLayerEvent());
                                          },
                                          child: const Icon(Icons.arrow_back)),
                                    ),
                                  ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                state.categoryNode.isEmpty
                                    ? AppText.discoverPageCategories
                                    : "${AppText.discoverPageCategories} ${state.categoryNodeString}",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: ListView.builder(
                        itemCount: state.selectedCategoryLayers.last.length,
                        itemBuilder: (context, index) => _CategoryItem(
                          category: state.selectedCategoryLayers.last[index],
                          onTap: () {
                            if (state.totalCategoryLayerLength - 2 > state.currentLayer) {
                              //todo: every category layer must have same size
                              BlocProvider.of<DiscoverBloc>(context).add(NextCategoryLayerEvent(
                                  state.selectedCategoryLayers.last[index], widget.categoriesByLayer[state.currentLayer + 1]));
                            } else {
                              //todo: go to products
                              DialogUtil(context).toast("Go do product page");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              CategoryFailState failState => SizedBox(), //todo: handle fail state
              DiscoverState _ => const DiscoverCategoriesSkelton(),
            });
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final Function() onTap;

  const _CategoryItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 70.0,
        child: Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            Text(
              category.name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
*/
