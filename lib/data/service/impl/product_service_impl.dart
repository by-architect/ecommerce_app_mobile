import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/data/model/Reviews.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/order_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/review_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exception_handler.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import '../../../sddklibrary/constant/exceptions/exceptions.dart';
import '../../../sddklibrary/helper/network_helper.dart';
import '../../model/tag.dart';

class ProductServiceImpl extends ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ResourceStatus<List<Category>>> getCategories() async {
    List<Category> categoryList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      final data = await _firestore
          .collection(FireStoreCollections.categories)
          .get()
          .timeout(AppDurations.postTimeout);
      data.docs.forEach((doc) {
        categoryList.add(Category.fromMap(doc.data()));
      });

      //todo: if there is no category in server, it is fatal error, check it
      if (categoryList.isEmpty) {
        return ResourceStatus.fail(Fail(
            userMessage: AppText.errorCategoriesNotFound.capitalizeFirstWord.get,
            exception: NullDataException(
                "Categories not found \n there might be no category added in server, fatal error")));
      }
      return ResourceStatus.success(categoryList);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<AllProductFeatures>> getProductFeatures() async {
    List<ProductFeature> productFeatureList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      final productFeaturesResponse = await _firestore
          .collection(FireStoreCollections.productFeatures)
          .get()
          .timeout(AppDurations.postTimeout);
      productFeaturesResponse.docs.forEach((doc) {
        productFeatureList.add(ProductFeature.fromMap(doc.data()));
      });
      return ResourceStatus.success(AllProductFeatures(productFeatureList));
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

/*
  @override
  Future<ResourceStatus<List<Product>>> getProducts() async {
    List<Product> productList = [];
    try {
      //check internet connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");


      //get products
      final productResponse = await _firestore.collection(FireStoreCollections.products).get().timeout(AppDurations.postTimeout);
      productResponse.docs.forEach((doc) {
        productList.add(Product.fromMap(doc.data()));
      });
      return ResourceStatus.success(productList);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }
*/

  @override
  Future<ResourceStatus<Product>> getProductsById(String id) async {
    try {
      //check internet connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      //get products
      final productResponse = await _firestore
          .collection(FireStoreCollections.products)
          .doc(id)
          .get()
          .timeout(AppDurations.postTimeout);
      if (!productResponse.exists) {
        return ResourceStatus.fail(
            Fail(userMessage: AppText.errorProductDoesNotExist.capitalizeFirstWord.get));
      }
      final Product product = Product.fromMap(productResponse.data()!);

      return ResourceStatus.success(product);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductsByCategory(String categoryId) async {
    List<Product> productList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) {
        throw NetworkDeviceDisconnectedException("Network Device is down");
      }

      //get product feature list
      final productFeatureResponse = await getProductFeatures();
      if (productFeatureResponse.status == Status.fail) {
        return ResourceStatus.fail(productFeatureResponse.error!);
      }
      final productFeatureList = productFeatureResponse.data!;

      //get products
      final productResponse = await _firestore
          .collection(FireStoreCollections.products)
          .where("categoryId", isEqualTo: categoryId)
          .get()
          .timeout(AppDurations.postTimeout);
      productResponse.docs.forEach((doc) {
        productList.add(Product.fromMap(doc.data()));
      });
      return ResourceStatus.success(productList); //get product feature list
    } catch (e, s) {
      return ExceptionHandler.firebaseResourceExceptionHandler(e, s);
    }
  }

  @override
  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch) {
    // TODO: implement addRecentSearch
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> clearAllRecentSearch() {
    // TODO: implement clearAllRecentSearch
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearchList) {
    // TODO: implement clearRecentSearch
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductsBySearchEvents(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags}) {
    //todo:get products which include one of the selected categories
    //todo: get products which include all of the selected tags
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches() {
    // TODO: implement getRecentSearches
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByDiscount(int count) {
    // TODO: implement getProductByDiscount
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count) {
    // TODO: implement getProductByBestSeller
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count) {
    // TODO: implement getProductByLastAdded
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<Reviews>> getReviews(String productId) {
    // TODO: implement getReviews
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<Product>>> getYouMayAlsoLike(String categoryId) {
    // TODO: implement getYouMayAlsoLike
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<ProductDetailsItem>>> getProductDetails(String productId) {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> addReview(ReviewState reviewState) {
    // TODO: implement addReview
    throw UnimplementedError();
  }


  @override
  Future<ResourceStatus> addOrder(OrderState purchaseProcess,String uid) {
    //todo: add all purchase states, paid process will be done, next one will be loading, others will be waiting
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<CartItem>>> getCart(String uid) {
    // TODO: dont get unavaliable carts

    // TODO: implement getCart
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> updateCartItem(CartItem cartItem) {
    // TODO: implement updateCartItem
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> deleteCartItem(String cartItemId) {
    // TODO: implement deleteCartItem
    throw UnimplementedError();
  }


  @override
  Future<ResourceStatus<List<Address>>> getAddresses(String uid) {
    // TODO: implement getAddresses
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> addAddress(AddressState addressState) {
    // TODO: implement addAddress
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> removeAddress(AddressState addressState) {
    // TODO: implement removeAddress
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<List<Address>>> selectAddress(AddressState addressState, String uid) {
    // TODO: implement selectAddress
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus<Address>> getSelectedAddress(String uid) {
    // TODO: implement getSelectedAddress
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> addToCart(CartItemState cartItemState, String uid) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }


  @override
  Future<ResourceStatus<List<OrderModel>>> getOrderList(String uid) {
    // TODO: implement getPurchaseProcessList
    throw UnimplementedError();
  }





  @override
  Future<ResourceStatus<List<Return>>> getReturnProcessList(String uid) {
    // TODO: implement getReturnProcessList
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> updateOrder(String orderId, OrderModel order) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> cancelOrder(OrderModel order) {
    // TODO: implement cancelOrder
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> updateReturnProcess(Return returnProcess) {
    // TODO: implement updateReturn
    throw UnimplementedError();
  }

  @override
  Future<ResourceStatus> addReturn(ReturnState returnProcess, String uid) {
    // TODO: implement addReturn
    throw UnimplementedError();
  }

}
