import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category_struct.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/presentation/discover/widget/categories_lister_widget.dart';
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
        child: Column(
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
            Expanded(
              child: CategoriesListerWidget(
                  onLastItemPressed: (category) {
                    BlocProvider.of<SearchBloc>(context).add(SelectedCategoriesEvent([category]));
                    BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              user: widget.user,
                              features: widget.features,
                              categories: widget.categories,
                            )));
                  }, categories: widget.categories,),
            ),
          ],
        ));
  }
}

