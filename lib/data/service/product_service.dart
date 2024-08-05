import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

import '../../sddklibrary/helper/resource.dart';

abstract class ProductService{
  Future<ResourceStatus<List<Category>>> getCategories();
  Future<ResourceStatus<List<ProductFeature>>> getProductFeatures();
  Future<ResourceStatus<List<Product>>> getProducts();
  Future<ResourceStatus<Product>> getProductById(String id);

}