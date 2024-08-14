import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';

import '../../sddklibrary/helper/resource.dart';

abstract class ProductService {
  Future<ResourceStatus<List<Category>>> getCategories();

  Future<ResourceStatus<List<ProductFeature>>> getProductFeatures();

  Future<ResourceStatus<List<Product>>> getProducts();

  Future<ResourceStatus<List<Product>>> getProductsByCategory(String categoryId);

  Future<ResourceStatus<Product>> getProductsById(String id);

  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearchList);

  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch);

  Future<ResourceStatus> clearAllRecentSearch();

  Future<ResourceStatus<List<Product>>> getProductsBySearchEvents(
      {String? searchText, List<ProductFeatureOption>? selectedFeatureOptions, Category? selectedCategory});
}
