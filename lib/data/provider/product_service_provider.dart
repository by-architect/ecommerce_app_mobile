import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/util/category_util.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_product_service.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';

import '../../sddklibrary/helper/resource.dart';
import '../model/product.dart';

class ProductServiceProvider {
  ProductService productService = FakeProductService();

  Future<Resource<List<List<Category>>>> getCategoriesByLayer() async {
    try {
      final categoriesResource = await productService.getCategories();
      if (categoriesResource.status == Status.fail) return Resource.fail(categoriesResource.error!);

      final categories = categoriesResource.data!;
      return Resource.success(CategoryUtil().sortCategoriesByLayer(categories));
    } catch (e, s) {
      return Resource.fail(Fail(userMessage: AppText.errorFetchingData, stackTrace: s, exception: e.toString()));
    }
  }

  Future<Resource<List<Product>>> getProducts() async {
    return productService.getProducts();
  }

  Future<Resource<Product>> getProductById(String id) async {
    return productService.getProductsById(id);
  }

  Future<Resource<List<Product>>> getProductsByCategory(String categoryId) async {
    return productService.getProductsByCategory(categoryId);
  }
}
