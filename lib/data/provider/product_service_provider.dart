import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_product_service.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';

import '../../sddklibrary/helper/resource.dart';
import '../model/product.dart';

class ProductServiceProvider {
  ProductService productService = ProductServiceImpl();

  Future<Resource<List<List<Category>>>> getCategoriesByLayer() async {
    try {
      List<List<Category>> categoryListByLayer = [];

      final categoriesResource = await productService.getCategories();
      if (categoriesResource.status == Status.fail) return Resource.fail(categoriesResource.error!);

      final categories = categoriesResource.data!;
      for (int layer = 0;; layer++) {
        final categoryLayer = categories.where((category) {
          return category.layer == layer;
        }).toList();
        if (categoryLayer.isEmpty) break;
        categoryListByLayer.insert(layer, categoryLayer);
      }
      return Resource.success(categoryListByLayer);
    } catch (e, s) {
      return Resource.fail(Fail(userMessage: AppText.errorFetchingData, stackTrace: s, exception: e.toString()));
    }
  }

  Future<Resource<List<Product>>> getProducts() async {
    return productService.getProducts();
  }

  Future<Resource<Product>> getProductById(String id) async {
    return productService.getProductById(id);
  }
}
