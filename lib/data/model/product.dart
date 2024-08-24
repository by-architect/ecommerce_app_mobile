import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import 'category_node.dart';

class Product {
  late final String productId;
  late final String name;
  late final String categoryId;

  late final String info;
  late final String returns;
  late final double cargoPrice;
  late final String? brandName;
  late final List<String> images;
  late final int buyTimes;

  ///product list
  late final DateTime addedTime;
  late final DateTime modifiedTime;
  late final int totalCount;
  late final String barcode;
  late final String id;
  late final double price;
  late final List<String> featureOptionIds;
  late final double? discount;

  int? get discountPercent => discount == null ? null : ((discount! / price) * 100).toInt();

  bool get availableInStock => totalCount != 0;

  double? get priceAfterDiscounting => discount == null ? null : (price - discount!);

  Product(
      {required this.productId,
      required this.name,
      required this.buyTimes,
      required this.addedTime,
      required this.categoryId,
      required this.info,
      required this.modifiedTime,
      required this.cargoPrice,
      required this.returns,
      required this.totalCount,
      required this.barcode,
      required this.images,
      required this.id,
      required this.featureOptionIds,
      required this.price,
      required this.discount,
      this.brandName});

  Product.fromMap(Map<String, dynamic> map, List<ProductFeature> allFeatures) {
    productId = map['productId'];
    name = map['name'];
    buyTimes = map['buyTimes'];
    addedTime = map['addedTime'];
    categoryId = map['categoryId'];
    info = map['explanation'];
    modifiedTime = map['modifiedTime'];
    cargoPrice = map['cargoPrice'];
    returns = map['returns'];
    totalCount = map['totalCount'];
    id = map['id'];
    barcode = map['barcode'];
    price = map['price'];
    discount = map['discount'];
    brandName = map['brandName'];

    images = map['images'] as List<String>;
    //todo: get the image from server

    featureOptionIds = map['feature'] as List<String>;

/*
    list.forEach((item) {
      final optionMap = item as Map<String, dynamic>;
      final originalFeature = allFeatures.lastWhere((feature) => feature.id == optionMap['featureId'].toString());

      ProductFeatureWithSelectedOption productFeatureSelectedOption = ProductFeatureWithSelectedOption(
          originalFeature.copyWith(), originalFeature.options.lastWhere((option) => option.id == optionMap['optionId'].toString()));

      featuresWithSelectedOptions.add(productFeatureSelectedOption);
    });
*/
  }

  Map<String, dynamic> toMap() {
    return {
/*
      "productId": productId,
      "name": name,
      "categoryId": categoryId,
      "explanation": info,
      "cargoPrice": cargoPrice,
      "totalCount": totalCount,
      "barcode": barcode,
      "image": images,
      "id": id,
      "featureOptionIds": featureOptionIds,
      "price": price,
      "discount": discount,
      "brandName": brandName,
*/
    };
  }

  ResourceStatus<CategoryNode> categoryNode(Categories categories) => categories.getNodeFromLastCategoryId(categoryId);

  // ResourceStatus<List<Category>> categoryNode(Categories categories) => categories.getNodeFromLastCategoryId(categoryId);

  @override
  String toString() {
    return 'Product{productId: $productId, name: $name, categoriesId: $categoryId, barcode: $barcode explanation: $info, cargoPrice: $cargoPrice, totalCount: $totalCount, id: $id, price: $price,  discount: $discount}';
  }
}
