import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_state.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/product/product_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/product/product_service_event.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/product/product_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/product_exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/category.dart';
import '../../../common/util/category_util.dart';
import '../../../data/model/product.dart';
import '../../../data/service/impl/product_service_impl.dart';
import '../../../data/service/product_service.dart';
import '../../../data/viewmodel/category/category_service_event.dart';
import '../../../sddklibrary/helper/Log.dart';
import '../../../sddklibrary/helper/resource.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<Category>> categoriesByLayer = [];

  @override
  void initState() {
    BlocProvider.of<CategoryServiceBloc>(context).add(GetCategoriesByLayerEvent());

    BlocProvider.of<ProductServiceBloc>(context).stream.listen((event) {
      switch (event) {
        case GetProductsByCategorySuccessState successState:
          Log.test(title: "product", data: successState.products.toString());
          Log.test(title: "categories", data: categoriesByLayer.toString());
          break;
        default:
          Log.test(title: "default");
          break;
      }
    });

    BlocProvider.of<CategoryServiceBloc>(context).stream.listen((category) {
      switch (category) {
        case GetCategoriesByLayerSuccessState successState:
          categoriesByLayer = successState.categories;
          break;
        case GetCategoriesByLayerFailState failState:
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            BlocBuilder<CategoryServiceBloc, CategoryServiceState>(
              builder: (BuildContext context, state) => ButtonPrimary(
                text: switch (BlocProvider.of<CategoryServiceBloc>(context).state) {
                  GetCategoriesByLayerLoadingState _ => "Loading",
                  GetCategoriesByLayerSuccessState successState => " Success",
                  GetCategoriesByLayerFailState _ => "Fail",
                  GetCategoriesByLayerInitState _ => "Init state",

                  // successState.categories.forEach((category)=>Log.test("categories",data: category.toString()));
                  // TODO: Handle this case.
                  CategoryServiceState() => ""
                },
                onTap: () {
                  BlocProvider.of<ProductServiceBloc>(context).add(GetProductsByCategoryEvent(""));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
