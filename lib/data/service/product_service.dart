import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

import '../../sddklibrary/helper/resource.dart';

abstract class ProductService{
  Future<Resource<List<Category>>> getCategories();
  Future<Resource<List<ProductFeature>>> getProductFeatures();
  Future<Resource<List<Product>>> getProducts();
  Future<Resource<Product>> getProductById(String id);

}