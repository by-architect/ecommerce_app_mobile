import 'dart:math';

import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

class FakeProductService implements ProductService {
  Random random = Random();

  @override
  Future<Resource<List<Category>>> getCategories() async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    List<Category> categories = [];

    return random.nextBool()
        ? Resource.success(categories)
        : Resource.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<Resource<Product>> getProductById(String id) async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    return random.nextBool()
        ? Resource.success(FakeProductModels.product1)
        : Resource.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<Resource<List<ProductFeature>>> getProductFeatures() async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    final List<ProductFeature> productFeatures = [FakeProductModels.productFeatureSize, FakeProductModels.productFeatureColor];
    return random.nextBool()
        ? Resource.success(productFeatures)
        : Resource.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<Resource<List<Product>>> getProducts() async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    final List<Product> productList = [FakeProductModels.product1, FakeProductModels.product2];
    return random.nextBool()
        ? Resource.success(productList)
        : Resource.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }
}
