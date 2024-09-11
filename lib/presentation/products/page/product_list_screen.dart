import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/prodcut_list_screen_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_list_screen_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_list_screen_state.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/skeleton/product_skeleton.dart';
import '../../common/widgets/fail_form.dart';
import '../../common/widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.productFeatures});

  final ProductFeatures productFeatures;
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {


  @override
  void deactivate() {
    BlocProvider.of<ProductScreenBloc>(context).add(ClearStateEvent());
    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarPopBack(),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              BlocBuilder<ProductScreenBloc, ProductScreenState>(
                  builder: (BuildContext context, ProductScreenState state) => switch (state) {
                        ProductsLoadingState() =>
                          Expanded(child: ListView.builder(itemCount: 6, itemBuilder: (context, index) => const ProductsSkeleton())),
                        ProductsFailState failState => Expanded(
                            child: FailForm(
                                fail: failState.fail,
                                onRefreshTap: () {
                                  BlocProvider.of<ProductScreenBloc>(context).add(GetProductsEvent());
                                }),
                          ),
                        ProductSuccessState _ || ProductScreenState _ => Expanded(
                            child: GridView.builder(
                              itemCount: state.products.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                productFeatures:widget.productFeatures,
                                product: state.products[index],
                              ),
                            ),
                          ),
                      }),
            ],
          ),
        ));
  }
}
