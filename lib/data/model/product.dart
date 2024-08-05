import 'package:ecommerce_app_mobile/common/util/category_util.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

import 'category.dart';

class Product {
  late final String productId;
  late final String name;
  late final String categoryId;

  // late final String addedDate;
  late final String explanation;
  late final double cargoPrice;

  //product list
  late final int totalCount;
  late final String barcode;
  late final String id;
  late final int waitingOnCartCount;
  late final double price;
  late final List<ProductFeature> productFeatures;
  late final double discount;

  Product(this.productId, this.name, this.categoryId, this.explanation, this.cargoPrice, this.totalCount, this.barcode, this.id,
      this.waitingOnCartCount, this.price, this.productFeatures, this.discount);

  Product.fromMap(Map<String, dynamic> map, List<ProductFeature> allFeatures) {
    productId = map['productId'];
    name = map['name'];
    categoryId = map['categoryId'];
    explanation = map['explanation'];
    cargoPrice = map['cargoPrice'];
    totalCount = map['totalCount'];
    id = map['id'];
    barcode = map['barcode'];
    waitingOnCartCount = map['waitingOnCartCount'];
    price = map['price'];
    discount = map['discount'];

    productFeatures = [];

    final list = map['feature'] as List<dynamic>;

    list.forEach((item) {
      final optionMap = item as Map<String, dynamic>;
      final originalFeature = allFeatures.lastWhere((feature) => feature.id == optionMap['featureId'].toString());

      final productFeature = originalFeature.copyWith(
          selectedOption: originalFeature.options.lastWhere((option) => option.id == optionMap['optionId'].toString()));

      productFeatures.add(productFeature);
    });
  }

  ResourceStatus<List<Category>> categoryNode(List<List<Category>> categoryLayers) =>
      CategoryUtil().getNodeFromLastCategoryId(categoryId, categoryLayers);

  @override
  String toString() {
    return 'Product{productId: $productId, name: $name, categoriesId: $categoryId, barcode: $barcode explanation: $explanation, cargoPrice: $cargoPrice, totalCount: $totalCount, id: $id, waitingOnCartCount: $waitingOnCartCount, price: $price, productFeatures: ${productFeatures.toString()}, discount: $discount}';
  }
}
