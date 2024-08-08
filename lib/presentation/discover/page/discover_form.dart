import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_state.dart';
import 'package:ecommerce_app_mobile/presentation/discover/widget/discover_skelton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/category.dart';
import '../../../sddklibrary/ui/dialog_util.dart';
import '../../home/widget/search_widget.dart';
import '../bloc/discover_event.dart';

class DiscoverForm extends StatefulWidget {
  const DiscoverForm({super.key});

  @override
  State<DiscoverForm> createState() => _DiscoverFormState();
}

class _DiscoverFormState extends State<DiscoverForm> {
  @override
  void initState() {
    BlocProvider.of<DiscoverBloc>(context).add(LoadCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: BlocBuilder<DiscoverBloc, DiscoverState>(builder: (BuildContext context, DiscoverState discoverState) {
        return switch (discoverState) {
          CategoryLoadingState _ => const DiscoverCategoriesSkeleton(),
          CategoryFailState failState => FailSkeleton(
              fail: failState.fail,
              onRefreshTap: () {
                BlocProvider.of<DiscoverBloc>(context).add(LoadCategoriesEvent());
              },
            ),
          CategorySuccessState successState => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Flexible(flex: 2, child: Padding(padding: EdgeInsets.all(AppSizes.defaultSpace), child: SearchWidget())),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace, vertical: AppSizes.defaultSpace / 2),
                    child: Row(
                      children: [
                        discoverState.categoryNode.length < 2
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
                            discoverState.categoryNodeString,
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
                    itemCount: discoverState.selectedCategoryLayers.last.length,
                    itemBuilder: (context, index) => _CategoryItem(
                      category: discoverState.selectedCategoryLayers.last[index],
                      onTap: () {
                        if (discoverState.totalCategoryLayerLength - 2 > discoverState.currentLayer) {
                          //todo: every category layer must have same size
                          BlocProvider.of<DiscoverBloc>(context)
                              .add(NextCategoryLayerEvent(discoverState.selectedCategoryLayers.last[index]));
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
          DiscoverState() => const DiscoverCategoriesSkeleton(),
        };
      }),
    );
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
