import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/row_classic.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/discover/bloc/discover_state.dart';
import 'package:ecommerce_app_mobile/presentation/discover/widget/discover_skelton.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_list_tile.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/presentation/search/page/search_screen.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/category.dart';
import '../../main/widget/search_widget.dart';
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
    BlocProvider.of<DiscoverBloc>(context).stream.listen(
      (state) {
        Log.test(title: "node",data: state.categoryStruct.categoryNode.toString());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: BlocBuilder<DiscoverBloc, DiscoverState>(builder: (BuildContext context, DiscoverState discoverState) {
        return switch (discoverState) {
          CategoryLoadingState _ => const DiscoverCategoriesSkeleton(),
          CategoryFailState failState => FailForm(
              fail: failState.fail,
              onRefreshTap: () {
                BlocProvider.of<DiscoverBloc>(context).add(LoadCategoriesEvent());
              },
            ),
          CategorySuccessState successState => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldSearch(
                  onFieldSubmitted: (value) {
                    SearchScreen.getProducts(outContext: context, events: []);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchScreen.getProducts(events: [SearchTextEvent(value ?? "")], outContext: context),
                    ));
                  },
                ),
                const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding / 2),
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
                                        BlocProvider.of<DiscoverBloc>(context).add(PreviousCategoryLayerEvent());
                                      },
                                      child: const Icon(Icons.arrow_back)),
                                ),
                              ),
                        Text(
                          discoverState.categoryStruct.isFirstLayer
                              ? AppText.commonPageCategories.capitalizeFirstWord
                              : "${AppText.commonPageCategories} > ${discoverState.categoryStruct.title}",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
                Expanded(
                  child: ListView.builder(
                    itemCount: discoverState.categoryStruct.currentLayer.length,
                    itemBuilder: (context, index) => ProductListTile(
                      title: discoverState.categoryStruct.currentLayer[index].name,
                      isShowBottomBorder: discoverState.categoryStruct.currentLayer[index].id == discoverState.categoryStruct.currentLayer.last.id,
                      press: () {
                        if(discoverState.categoryStruct.isLastLayer(discoverState.categoryStruct.currentLayer[index])) {

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen.getProducts(events: [
                              SelectedCategoriesEvent([discoverState.categoryStruct.currentLayer[index]])
                            ], outContext: context),
                          ));
                        }else {

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
            ),
          DiscoverState() => const DiscoverCategoriesSkeleton(),
        };
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
    )*//*

        ;
  }
}
*/
