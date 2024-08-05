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
  Future<ResourceStatus<List<Category>>> getCategories() async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    List<Category> categories = [];

    return random.nextBool()
        ? ResourceStatus.success(categories)
        : ResourceStatus.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<Product>> getProductById(String id) async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.product1)
        : ResourceStatus.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<ProductFeature>>> getProductFeatures() async {
    Resource.loading();
    Future.delayed(const Duration(seconds: 2));
    final List<ProductFeature> productFeatures = [FakeProductModels.productFeatureSize, FakeProductModels.productFeatureColor];
    return random.nextBool()
        ? ResourceStatus.success(productFeatures)
        : ResourceStatus.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<Product>>> getProducts() async {

    Future.delayed(const Duration(seconds: 2));
    final List<Product> productList = [FakeProductModels.product1, FakeProductModels.product2];
    return random.nextBool()
        ? ResourceStatus.success(productList)
        : ResourceStatus.fail(DefaultError(userMessage: "Fake product service fail situation"));
  }
}
