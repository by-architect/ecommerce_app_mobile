import 'dart:math';

import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

class FakeProductService implements ProductService {
  Random random = Random();

  @override
  Future<ResourceStatus<List<Category>>> getCategories() async {
    // await Future.delayed(const Duration(seconds: 2));
    List<Category> categories = [
      FakeProductModels.category1,
      FakeProductModels.category2,
      FakeProductModels.category3,
      FakeProductModels.category4,
      FakeProductModels.category21,
      FakeProductModels.category22,
      FakeProductModels.category23,
      FakeProductModels.category231
    ];

    return ResourceStatus.success(categories);

    return random.nextBool() ? ResourceStatus.success(categories) : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<Product>> getProductById(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.product1)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<ProductFeature>>> getProductFeatures() async {
    await Future.delayed(const Duration(seconds: 2));
    final List<ProductFeature> productFeatures = [FakeProductModels.productFeatureSize, FakeProductModels.productFeatureColor];
    return random.nextBool() ? ResourceStatus.success(productFeatures) : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<Product>>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    final List<Product> productList = [FakeProductModels.product1, FakeProductModels.product2];
    return random.nextBool() ? ResourceStatus.success(productList) : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }
}
