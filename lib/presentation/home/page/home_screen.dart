import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product.dart';

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
            ButtonPrimary(
              text: "out",
              onTap: () {
                ProductService productService = ProductServiceImpl();
                productService.getProductById("cJK0pkjArGPurrG3OnFO").then((resource) {
                  switch (resource.status) {
                    case Status.success:
                      Product product = resource.data!;
                      Log.test(product.toString());
                    case Status.fail:
                      Log.test(resource.error!.userMessage);
                    case Status.loading:
                    // TODO: Handle this case.
                    case Status.stable:
                    // TODO: Handle this case.
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
