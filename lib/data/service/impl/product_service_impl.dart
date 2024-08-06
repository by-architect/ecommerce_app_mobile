import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exception_handler.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

import '../../../sddklibrary/constant/exceptions/exceptions.dart';
import '../../../sddklibrary/helper/network_helper.dart';

class ProductServiceImpl extends ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ResourceStatus<List<Category>>> getCategories() async {
    List<Category> categoryList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      final data = await _firestore.collection(FireStoreCollections.categories).get().timeout(AppDurations.postTimeout);
      data.docs.forEach((doc) {
        categoryList.add(Category.fromMap(doc.data()));
      });
      return ResourceStatus.success(categoryList);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<List<ProductFeature>>> getProductFeatures() async {
    List<ProductFeature> productFeatureList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      final productFeaturesResponse =
          await _firestore.collection(FireStoreCollections.productFeatures).get().timeout(AppDurations.postTimeout);
      productFeaturesResponse.docs.forEach((doc) {
        productFeatureList.add(ProductFeature.fromMap(doc.data()));
      });
      return ResourceStatus.success(productFeatureList);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<List<Product>>> getProducts() async {
    List<Product> productList = [];
    try {
      //check internet connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //get product feature list
      final productFeatureResponse = await getProductFeatures();
      if (productFeatureResponse.status == Status.fail) return ResourceStatus.fail(productFeatureResponse.error!);
      final productFeatureList = productFeatureResponse.data!;

      //get products
      final productResponse = await _firestore.collection(FireStoreCollections.products).get().timeout(AppDurations.postTimeout);
      productResponse.docs.forEach((doc) {
        productList.add(Product.fromMap(doc.data(), productFeatureList));
      });
      return ResourceStatus.success(productList);
    } catch (exception, stackTrace) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception, stackTrace);
    }
  }

  @override
  Future<ResourceStatus<Product>> getProductsById(String id) async {
    try {
      //check internet connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //get product feature list
      final productFeatureResponse = await getProductFeatures();
      if (productFeatureResponse.status == Status.fail) return ResourceStatus.fail(productFeatureResponse.error!);
      final productFeatureList = productFeatureResponse.data!;

      //get products
      final productResponse = await _firestore.collection(FireStoreCollections.products).doc(id).get().timeout(AppDurations.postTimeout);
      if (!productResponse.exists) return ResourceStatus.fail(Fail(userMessage: AppText.errorProductDoesNotExist));
      final Product product = Product.fromMap(productResponse.data()!, productFeatureList);

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
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //get product feature list
      final productFeatureResponse = await getProductFeatures();
      if (productFeatureResponse.status == Status.fail) return ResourceStatus.fail(productFeatureResponse.error!);
      final productFeatureList = productFeatureResponse.data!;

      //get products
      final productResponse = await _firestore
          .collection(FireStoreCollections.products)
          .where("categoryId", isEqualTo: categoryId)
          .get()
          .timeout(AppDurations.postTimeout);
      productResponse.docs.forEach((doc) {
        productList.add(Product.fromMap(doc.data(), productFeatureList));
      });
      return ResourceStatus.success(productList); //get product feature list
    } catch (e, s) {
      return ExceptionHandler.firebaseResourceExceptionHandler(e, s);
    }
  }
}
