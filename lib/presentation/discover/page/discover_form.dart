import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_list_tile.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/user.dart';
import '../../main/widget/search_widget.dart';
import '../../search/bloc/search_event.dart';
import '../../search/page/search_screen.dart';
import '../bloc/discover_event.dart';

class DiscoverForm extends StatefulWidget {
  final AllProductFeatures features;
  final Categories categories;
  final User? user;

  const DiscoverForm({super.key, required this.features, required this.categories, required this.user});

  @override
  State<DiscoverForm> createState() => _DiscoverFormState();
}

class _DiscoverFormState extends State<DiscoverForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (BuildContext context, DiscoverState discoverState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldSearch(
              onFieldSubmitted: (value) {
                if (value == null || value.isEmpty) return;
                BlocProvider.of<SearchBloc>(context).add(SearchTextEvent(value));
                BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      user: widget.user,
                          features: widget.features,
                          categories: widget.categories,
                        )));
              },
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
                child: Row(
                  children: [
                    discoverState.categoryStruct.isFirstLayer
                        ? const Flexible(flex: 1, child: SizedBox())
                        : Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<DiscoverBloc>(context)
                                        .add(PreviousCategoryLayerEvent());
                                  },
                                  child: const Icon(Icons.arrow_back)),
                            ),
                          ),
                    Text(
                      discoverState.categoryStruct.isFirstLayer
                          ? AppText.commonPageCategories.capitalizeFirstWord.get
                          : "${AppText.commonPageCategories} > ${discoverState.categoryStruct.title}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: discoverState.categoryStruct.currentLayer.length,
                itemBuilder: (context, index) => ProductListTile(
                  title: discoverState.categoryStruct.currentLayer[index].name,
                  isShowBottomBorder: discoverState.categoryStruct.currentLayer[index].id ==
                      discoverState.categoryStruct.currentLayer.last.id,
                  press: () {
                    if (discoverState.categoryStruct
                        .isLastLayer(discoverState.categoryStruct.currentLayer[index])) {
                      BlocProvider.of<SearchBloc>(context)
                          .add(
                          SelectedCategoriesEvent([discoverState.categoryStruct.currentLayer[index]])
);
                      BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen(
                             user: widget.user,
                            features: widget.features,
                            categories: widget.categories,
                          )));
                    } else {
                      BlocProvider.of<DiscoverBloc>(context)
                          .add(NextCategoryLayerEvent(discoverState.categoryStruct.currentLayer[index]));
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
      }),
    );
  }
}

/*
class _CategoryItem extends StatelessWidget {
  final Category category;
  final Function() onTap;

  const _CategoryItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RowItemDefault(
            text: Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Text(
                  category.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic, fontSize: 30),
                ),
              ],
            ),
            onTap: onTap)
        */
/*GestureDetector(
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
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 30),
            ),
          ],
        ),
      ),
    )*/ /*

        ;
  }
}
*/
