import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/util/category_util.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_product_service.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';

import '../../sddklibrary/helper/resource.dart';
import '../model/product.dart';
import '../model/product_feature.dart';
import '../model/tag.dart';

class ProductServiceProvider {
  ProductService productService = FakeProductService();

  Future<ResourceStatus<List<List<Category>>>> getCategoriesByLayer() async {
    try {
      final categoriesResource = await productService.getCategories();
      if (categoriesResource.status == Status.fail) return ResourceStatus.fail(categoriesResource.error!);

      final categories = categoriesResource.data!;
      return ResourceStatus.success(CategoryUtil().sortCategoriesByLayer(categories));
    } catch (e, s) {
      return ResourceStatus.fail(Fail(userMessage: AppText.errorFetchingData, stackTrace: s, exception: e.toString()));
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

  Future<Resource<List<Product>>> getProductsBySearchEvent(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags}) async {
    return productService.getProductsBySearchEvents(
        selectedFeatureOptions: selectedFeatureOptions, selectedCategories: selectedCategories, searchText: searchText,selectedTags: selectedTags);
  }

  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch) {
    return productService.addRecentSearch(recentSearch);
  }

  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearch) {
    return productService.clearRecentSearch(recentSearch);
  }

  Future<ResourceStatus> clearAllRecentSearch() {
    return productService.clearAllRecentSearch();
  }

  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches() {
    return productService.getRecentSearches();
  }

  Future<ResourceStatus> deleteSearchHistory(List<RecentSearch> search) async {
    //todo: unimplemented
    const Duration(seconds: 1);
    return const ResourceStatus.success("");
  }

  Future<ResourceStatus<List<ProductFeature>>> getProductFeatures() {
    return productService.getProductFeatures();
  }

  Future<ResourceStatus<List<Product>>> getProductByDiscount(int count) {
    return productService.getProductByDiscount(count);
  }
  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count) {
    return productService.getProductByBestSeller(count);
  }
  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count) {
    return productService.getProductByLastAdded(count);
  }

}
