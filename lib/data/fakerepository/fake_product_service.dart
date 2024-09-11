import 'dart:math';

import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import '../../presentation/products/bloc/review_state.dart';
import '../model/Reviews.dart';
import '../model/tag.dart';

class FakeProductService implements ProductService {
  Random random = Random();

  @override
  Future<ResourceStatus<List<Category>>> getCategories() async {
    await Future.delayed(const Duration(seconds: 2));
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

    // return ResourceStatus.success(categories);
    // return ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));

    return random.nextBool()
        ? ResourceStatus.success(categories)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<Product>> getProductsById(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.product1)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<AllProductFeatures>> getProductFeatures() async {
    await Future.delayed(const Duration(seconds: 2));
    return ResourceStatus.success(FakeProductModels.allProductFeatures);
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.allProductFeatures)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }


  @override
  Future<ResourceStatus<List<Product>>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(seconds: 2));
    final List<Product> productList = [FakeProductModels.product1, FakeProductModels.product2];
    return random.nextBool()
        ? ResourceStatus.success(productList
            .where(
              (product) => product.categoryId == categoryId,
            )
            .toList())
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductsBySearchEvents(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags}) async {
    await Future.delayed(const Duration(seconds: 2));

    return ResourceStatus.success(FakeProductModels.products);
    // return ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));

    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.products)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(RecentSearch(random.nextDouble().toString(), "", recentSearch));
  }

  @override
  Future<ResourceStatus> clearAllRecentSearch() async {
    return random.nextBool()
        ? const ResourceStatus.success("")
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearchList) async {
    return random.nextBool()
        ? const ResourceStatus.success("")
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches() async {
    return ResourceStatus.success(FakeProductModels.recentSearches);
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.recentSearches)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByDiscount(int count) async {
    // await Future.delayed(const Duration(seconds: 2));
    final List<Product> products = FakeProductModels.products.where((product) => product.subProducts.getIdealSubProduct.discount != 0).toList();
    return ResourceStatus.success(products);
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count) async {
    // await Future.delayed(const Duration(seconds: 2));
    return ResourceStatus.success(FakeProductModels.products);
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count) async {
    // await Future.delayed(const Duration(seconds: 2));
    return ResourceStatus.success(FakeProductModels.products);
  }

  @override
  Future<ResourceStatus<Reviews>> getReviews(String productId) async {
    return ResourceStatus.success(switch (random.nextInt(2)) {
      0 => FakeProductModels.reviews1(productId),
      1 => FakeProductModels.reviews2(productId),
      2 => FakeProductModels.reviews3(productId),
      int() => FakeProductModels.reviews3(productId),
    });
  }

  @override
  Future<ResourceStatus<List<Product>>> getYouMayAlsoLike(String categoryId) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(switch (random.nextInt(2)) {
      0 => FakeProductModels.products,
      1 => FakeProductModels.products2,
      2 => FakeProductModels.products3,
      int() => FakeProductModels.products4,
    });
  }

  @override
  Future<ResourceStatus<List<ProductDetailsItem>>> getProductDetails(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(FakeProductModels.productDetails);
  }

  @override
  Future<ResourceStatus> addReview(ReviewState reviewState) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductsOnCart() async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(FakeProductModels.products);
  }
}
