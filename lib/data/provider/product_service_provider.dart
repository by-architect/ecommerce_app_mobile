import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_product_service.dart';
import 'package:ecommerce_app_mobile/data/model/Reviews.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/service/impl/product_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/order_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';

import '../../presentation/return/bloc/return_state.dart';
import '../../presentation/products/bloc/review_state.dart';
import '../../sddklibrary/util/resource.dart';
import '../model/product.dart';
import '../model/product_feature.dart';
import '../model/order_process.dart';
import '../model/tag.dart';

class ProductServiceProvider {
  final ProductService _fakeProductService = FakeProductService();
  final ProductService _productService = ProductServiceImpl();

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
    return _fakeProductService.getProductsById(id);
  }

  Future<Resource<List<Product>>> getProductsBySearchEvent(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags}) async {
    return _fakeProductService.getProductsBySearchEvents(
        selectedFeatureOptions: selectedFeatureOptions,
        selectedCategories: selectedCategories,
        searchText: searchText,
        selectedTags: selectedTags);
  }

  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch) {
    return _fakeProductService.addRecentSearch(recentSearch);
  }

  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearch) {
    return _fakeProductService.clearRecentSearch(recentSearch);
  }

  Future<ResourceStatus> clearAllRecentSearch() {
    return _fakeProductService.clearAllRecentSearch();
  }

  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches() {
    return _fakeProductService.getRecentSearches();
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
    return _fakeProductService.getProductByDiscount(count);
  }

  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count) {
    return _fakeProductService.getProductByBestSeller(count);
  }

  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count) {
    return _fakeProductService.getProductByLastAdded(count);
  }

  Future<ResourceStatus<Reviews>> getReviews(String productId) {
    return _fakeProductService.getReviews(productId);
  }

  Future<ResourceStatus<List<Product>>> getYouMayAlsoLike(String categoryId) {
    return _fakeProductService.getYouMayAlsoLike(categoryId);
  }

  Future<ResourceStatus<List<ProductDetailsItem>>> getProductDetails(String productId) {
    return _fakeProductService.getProductDetails(productId);
  }

  Future<ResourceStatus> addReview(ReviewState reviewState) async {
    return _fakeProductService.addReview(reviewState);
  }

  addReviewAsResource(ReviewState reviewState, Function(Resource) resource) async {
    resource(Resource.loading());
    final reviewResource = await _fakeProductService.addReview(reviewState);
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

  Future<ResourceStatus> addOrder(OrderState purchaseProcessState, String uid) {
    return _fakeProductService.addOrder(purchaseProcessState, uid);
  }


  Future<ResourceStatus<List<OrderModel>>> getOrderList(String uid) {
    return _fakeProductService.getOrderList(uid);
  }
  Future<ResourceStatus> cancelOrder(OrderModel order) {
    return _fakeProductService.cancelOrder(order);
  }

  Future<ResourceStatus> addReturnProcess(ReturnState returnProcess, String uid) {
    return _fakeProductService.addReturn(returnProcess, uid);
  }


  Future<ResourceStatus<List<ReturnModel>>> getReturnProcessList(String uid) {
    return _fakeProductService.getReturnProcessList(uid);
  }

  Future<ResourceStatus> updateReturnProcess(ReturnModel returnProcess) {
    return _fakeProductService.updateReturnProcess(returnProcess);
  }

  Future<ResourceStatus<List<CartItem>>> getCart(User user) {
    return _fakeProductService.getCart(user.uid);
  }

  Future updateCartItem(CartItem cartItem, User user) {
    return _fakeProductService.updateCartItem(
      cartItem,
    );
  }

  Future<ResourceStatus> addCartItem(CartItemState cartItem, String uid) {
    return _fakeProductService.addToCart(cartItem, uid);
  }

  Future deleteCartItem(String cartItem) {
    return _fakeProductService.deleteCartItem(cartItem);
  }

  Future<ResourceStatus> addAddress(AddressState addressState) {
    return _fakeProductService.addAddress(addressState);
  }

  Future<ResourceStatus> removeAddress(AddressState addressState) {
    return _fakeProductService.removeAddress(addressState);
  }

  Future<ResourceStatus<List<Address>>> selectAddress(AddressState addressState,String uid) {
    return _fakeProductService.selectAddress(addressState,uid);

  }

  Future<ResourceStatus<List<Address>>> getAddresses(User user) {
    return _fakeProductService.getAddresses(user.uid);
  }

  Future<ResourceStatus<Address>> getSelectedAddress(User user) {
    return _fakeProductService.getSelectedAddress(user.uid);
  }

  getProductsOnCartAsResource(Function(Resource) resource, User user) async {
    resource(Resource.loading());
    final productResource = await _fakeProductService.getCart(user.uid);
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
