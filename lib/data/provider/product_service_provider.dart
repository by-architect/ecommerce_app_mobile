import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_product_service.dart';
import 'package:ecommerce_app_mobile/data/model/Reviews.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/purchase_process_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../presentation/products/bloc/review_state.dart';
import '../../sddklibrary/util/resource.dart';
import '../model/product.dart';
import '../model/product_feature.dart';
import '../model/tag.dart';

class ProductServiceProvider {
  final ProductService _productService = FakeProductService();

  Future<ResourceStatus<Categories>> getCategoriesByLayer() async {
    try {
      final categoriesResource = await _productService.getCategories();
      if (categoriesResource.status == Status.fail) {
        return ResourceStatus.fail(categoriesResource.error!);
      }

      final categories = categoriesResource.data!;
      return ResourceStatus.success(Categories(categories));
    } catch (e, s) {
      return ResourceStatus.fail(
          Fail(userMessage: AppText.errorFetchingData.capitalizeFirstWord.get, stackTrace: s, exception: e.toString()));
    }
  }

/*
  getCategoriesByLayerResource(Function(Resource<Categories>) emit) async {
    emit(Resource.loading());
    try {
      final categoriesResource = await productService.getCategories();
      if (categoriesResource.status == Status.fail) {
        emit(ResourceStatus.fail(categoriesResource.error!));
      }

      final categories = categoriesResource.data!;
      emit(ResourceStatus.success(Categories(categories)));
    } catch (e, s) {
      emit(ResourceStatus.fail(Fail(
          userMessage: AppText.errorFetchingData.capitalizeFirstWord.get,
          stackTrace: s,
          exception: e.toString())));
    }
  }
*/

/*
  Future<Resource<List<Product>>> getProducts() async {
    return productService.getProducts();
  }
*/

  Future<Resource<Product>> getProductById(String id) async {
    return _productService.getProductsById(id);
  }

  Future<Resource<List<Product>>> getProductsByCategory(String categoryId) async {
    return _productService.getProductsByCategory(categoryId);
  }

  Future<Resource<List<Product>>> getProductsBySearchEvent(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags}) async {
    return _productService.getProductsBySearchEvents(
        selectedFeatureOptions: selectedFeatureOptions,
        selectedCategories: selectedCategories,
        searchText: searchText,
        selectedTags: selectedTags);
  }

  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch) {
    return _productService.addRecentSearch(recentSearch);
  }

  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearch) {
    return _productService.clearRecentSearch(recentSearch);
  }

  Future<ResourceStatus> clearAllRecentSearch() {
    return _productService.clearAllRecentSearch();
  }

  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches() {
    return _productService.getRecentSearches();
  }

  Future<ResourceStatus> deleteSearchHistory(List<RecentSearch> search) async {
    //todo: unimplemented
    const Duration(seconds: 1);
    return const ResourceStatus.success("");
  }

  Future<ResourceStatus<AllProductFeatures>> getProductFeatures() {
    return _productService.getProductFeatures();
  }

/*
  getProductFeaturesResource(Function(Resource<ProductFeatures>) emit) async {
    emit(Resource.loading());
    try {
      final productFeatureResource = await productService.getProductFeatures();
      if (productFeatureResource.status == Status.fail) {
        emit(ResourceStatus.fail(productFeatureResource.error!));
      }
      emit(ResourceStatus.success(productFeatureResource.data!));
    } catch (e, s) {
      emit(ResourceStatus.fail(Fail(
          userMessage: AppText.errorFetchingData.capitalizeFirstWord.get,
          stackTrace: s,
          exception: e.toString())));
    }
  }
*/

  Future<ResourceStatus<List<Product>>> getProductByDiscount(int count) {
    return _productService.getProductByDiscount(count);
  }

  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count) {
    return _productService.getProductByBestSeller(count);
  }

  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count) {
    return _productService.getProductByLastAdded(count);
  }

  Future<ResourceStatus<Reviews>> getReviews(String productId) {
    return _productService.getReviews(productId);
  }

  Future<ResourceStatus<List<Product>>> getYouMayAlsoLike(String categoryId) {
    return _productService.getYouMayAlsoLike(categoryId);
  }

  Future<ResourceStatus<List<ProductDetailsItem>>> getProductDetails(String productId) {
    return _productService.getProductDetails(productId);
  }

  Future<ResourceStatus> addReview(ReviewState reviewState) async {
    return _productService.addReview(reviewState);
  }

  addReviewAsResource(ReviewState reviewState, Function(Resource) resource) async {
    resource(Resource.loading());
    final reviewResource = await _productService.addReview(reviewState);
    switch (reviewResource.status) {
      case Status.success:
        resource(Resource.success(reviewResource.data));
        break;
      case Status.fail:
        resource(Resource.fail(reviewResource.error!));
        break;
      case Status.loading:
        resource(Resource.loading());
        break;
      case Status.stable:
        break;
    }
  }

  Future<ResourceStatus> addPurchaseProcess(PurchaseProcessState purchaseProcessState, String uid) {
    return _productService.addPurchaseProcess(purchaseProcessState, uid);
  }

  Future<ResourceStatus<List<CartItem>>> getCart(User user) {
    return _productService.getCart(user.uid);
  }

  Future updateCartItem(CartItem cartItem, User user) {
    return _productService.updateCartItem(
      cartItem,
    );
  }

  Future<ResourceStatus> addCartItem(CartItemState cartItem, String uid) {
    return _productService.addToCart(cartItem, uid);
  }

  Future deleteCartItem(String cartItem) {
    return _productService.deleteCartItem(cartItem);
  }

  Future<ResourceStatus> addAddress(AddressState addressState) {
    return _productService.addAddress(addressState);
  }

  Future<ResourceStatus> removeAddress(AddressState addressState) {
    return _productService.removeAddress(addressState);
  }

  Future<ResourceStatus<List<Address>>> selectAddress(AddressState addressState,String uid) {
    return _productService.selectAddress(addressState,uid);

  }

  Future<ResourceStatus<List<Address>>> getAddresses(User user) {
    return _productService.getAddresses(user.uid);
  }

  Future<ResourceStatus<Address>> getSelectedAddress(User user) {
    return _productService.getSelectedAddress(user.uid);
  }

  getProductsOnCartAsResource(Function(Resource) resource, User user) async {
    resource(Resource.loading());
    final productResource = await _productService.getCart(user.uid);
    switch (productResource.status) {
      case Status.success:
        resource(Resource.success(productResource.data));
        break;
      case Status.fail:
        resource(Resource.fail(productResource.error!));
        break;
      case Status.loading:
        resource(Resource.loading());
        break;
      case Status.stable:
        break;
    }
  }
}
