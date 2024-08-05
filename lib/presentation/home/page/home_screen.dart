import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_state.dart';
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
    BlocProvider.of<CategoryServiceBloc>(context).add(GetCategoriesEvent());
    BlocProvider.of<CategoryServiceBloc>(context).stream.listen((category) {
      switch (category) {
        case GetCategoriesByLayerSuccessState successState:
          categoriesByLayer = successState.categories;
/*
          try{
            CategoryNode categoryNode = CategoryNode.fromLastCategoryId("LvmixFlLo1HLDvXAaFBQ", successState.categories);
            Log.test(message: "category node", data: categoryNode.categories.toString());
          }catch(exc,st){
            if(exc is CategoryException) {
              Fail(exception: exc.message,userMessage: "" );
            }
          }
*/
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
                  ProductService productService = ProductServiceImpl();
                  productService.getProductById("cJK0pkjArGPurrG3OnFO").then((resource) {
                    switch (resource.status) {
                      case Status.success:
                        Product product = resource.data!;
                        Log.test(title: "product", data: product.toString());
                        Log.test(title: "categories", data: categoriesByLayer.toString());
                        ResourceStatus<List<Category>> categoryNode = product.categoryNode(categoriesByLayer);
                        Log.test(title: "category node of product", data: categoryNode.data?[0].toString());
                      case Status.fail:
                      case Status.loading:
                      // TODO: Handle this case.
                      case Status.stable:
                      // TODO: Handle this case.
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
