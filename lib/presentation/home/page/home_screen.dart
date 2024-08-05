
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_bloc.dart';
import 'package:ecommerce_app_mobile/data/viewmodel/category/category_service_state.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
/*
                  BlocProvider.of<CategoryServiceBloc>(context).add(GetCategoriesEvent());
                  BlocProvider.of<CategoryServiceBloc>(context).stream.listen((category) {
                    switch (category) {
                      case GetCategoriesByLayerSuccessState successState:
                        CategoryNode categoryNode = CategoryNode.fromLastCategoryId("15", successState.categories);
                        Log.test(message: "category node", data: categoryNode.categories.toString());
                        break;
                      case GetCategoriesByLayerFailState failState:
                        break;
                    }
                  });
*/
/*
                  ProductService productService = ProductServiceImpl();
                  productService.getProductById("cJK0pkjArGPurrG3OnFO").then((resource) {
                    switch (resource.status) {
                      case Status.success:
                        Product product = resource.data!;
                        Log.test(data: product.toString());
                      case Status.fail:
                      case Status.loading:
                      // TODO: Handle this case.
                      case Status.stable:
                      // TODO: Handle this case.
                    }
                  });
*/
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
