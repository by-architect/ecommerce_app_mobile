import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/exception_handler.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/common/constant/timeouts.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

import '../../../sddklibrary/constant/exceptions/network_exceptions.dart';
import '../../../sddklibrary/helper/network_helper.dart';

class ProductServiceImpl extends ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Resource<List<Category>>> getCategories() async {
    List<Category> categoryList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      final data = await _firestore.collection(FireStoreCollections.categories).get().timeout(Timeouts.postTimeout);
      data.docs.forEach((doc) {
        categoryList.add(Category.fromMap(doc.data()));
      });
      return Resource.success(categoryList);
    } catch (exception) {
      return ExceptionHandler.firebaseResourceExceptionHandler(exception);
    }
  }

  @override
  Future<Resource<List<ProductFeature>>> getProductFeatures() async {
    List<ProductFeature> productFeatureList = [];
    try {
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      final productFeaturesResponse = await _firestore.collection(FireStoreCollections.productFeatures).get().timeout(Timeouts.postTimeout);
      productFeaturesResponse.docs.forEach((doc) {
        productFeatureList.add(ProductFeature.fromMap(doc.data()));
      });
      return Resource.success(productFeatureList);
    } catch (exception) {
      ExceptionHandler.firebaseResourceExceptionHandler(exception);
    }
    return Resource.loading();
  }

  @override
  Future<Resource<List<Product>>> getProducts() async {
    List<Product> productList = [];
    try {
      //check internet connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //get product feature list
      final productFeatureResponse = await getProductFeatures();
      if(productFeatureResponse.status == Status.fail) return Resource.fail(productFeatureResponse.error!);
      final productFeatureList  = productFeatureResponse.data!;

      //get products
      final productResponse = await _firestore.collection(FireStoreCollections.products).get().timeout(Timeouts.postTimeout);
      productResponse.docs.forEach((doc) {
        productList.add(Product.fromMap(doc.data(),productFeatureList));
      });
      return Resource.success(productList);
    } catch (exception) {
      ExceptionHandler.firebaseResourceExceptionHandler(exception);
    }
    return Resource.loading();
  }

  @override
  Future<Resource<Product>> getProductById(String id) async {
    try {
      //check internet connection
      final networkConnection = await NetworkHelper().isConnectedToNetwork();
      if (!networkConnection.isConnected) throw NetworkDeviceDisconnectedException("Network Device is down");

      //get product feature list
      final productFeatureResponse = await getProductFeatures();
      if(productFeatureResponse.status == Status.fail) return Resource.fail(productFeatureResponse.error!);
      final productFeatureList  = productFeatureResponse.data!;

      //get products
      final productResponse = await _firestore.collection(FireStoreCollections.products).doc(id).get().timeout(Timeouts.postTimeout);
      if (!productResponse.exists) return Resource.fail(DefaultError(userMessage: AppText.errorProductDoesNotExist));
      final Product product = Product.fromMap(productResponse.data()!,  productFeatureList);

      return Resource.success(product);
    } catch (exception) {
      ExceptionHandler.firebaseResourceExceptionHandler(exception);
    }
    return Resource.loading();
  }


}
