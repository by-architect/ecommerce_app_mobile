import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/purchase_process_state.dart';

import '../../presentation/products/bloc/review_state.dart';
import '../../sddklibrary/util/resource.dart';
import '../model/Reviews.dart';
import '../model/review.dart';
import '../model/tag.dart';
import '../model/user.dart';

abstract class ProductService {
  Future<ResourceStatus<List<Category>>> getCategories();

  Future<ResourceStatus<AllProductFeatures>> getProductFeatures();

  // Future<ResourceStatus<List<Product>>> getProducts();

  Future<ResourceStatus<List<Product>>> getProductsByCategory(String categoryId);

  Future<ResourceStatus<Product>> getProductsById(String id);

  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearchList);

  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch);

  Future<ResourceStatus> clearAllRecentSearch();

  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches();

  Future<ResourceStatus<List<Product>>> getProductByDiscount(int count);

  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count);

  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count);

  Future<ResourceStatus<List<Product>>> getProductsBySearchEvents(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags});


  Future<ResourceStatus<Reviews>> getReviews(String productId);
  Future<ResourceStatus> addReview(ReviewState reviewState);
  Future<ResourceStatus<List<Product>>> getYouMayAlsoLike(String categoryId);
  Future<ResourceStatus<List<ProductDetailsItem>>> getProductDetails(String productId);

  Future<ResourceStatus> addPurchaseProcess(PurchaseProcessState purchaseProcess, String uid);
  Future<ResourceStatus<List<CartItem>>> getCart(String uid);
  Future<ResourceStatus> updateCartItem(CartItem cartItem);
  Future<ResourceStatus> deleteCartItem(String cartItemId);


  Future<ResourceStatus> addAddress(AddressState addressState);
  Future<ResourceStatus<List<Address>>> selectAddress(AddressState addressState,String uid);
  Future<ResourceStatus> removeAddress(AddressState addressState);
  Future<ResourceStatus<List<Address>>> getAddresses(String uid);
  Future<ResourceStatus<Address>> getSelectedAddress(String uid);

}
