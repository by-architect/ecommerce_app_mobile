import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import 'category_node.dart';

class Product {
  late final String id;
  late final String name;
  late final String categoryId;
  late final String info;
  late final String returns;
  late final double? cargoPrice;
  late final String? brandName;
  late final List<String> images;
  late final SubProducts subProducts;

  String get firstImageOrEmpty => images.firstOrNull ?? "";

  String get brandNameOrEmpty => brandName ?? "";

  Product(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.info,
      required this.cargoPrice,
      required this.returns,
      required this.images,
      this.brandName,
      required this.subProducts});

  Product.fromMap(Map<String, dynamic> map) {
/*
    id = map['productId'];
    name = map['name'];
    categoryId = map['categoryId'];
    info = map['explanation'];
    cargoPrice = map['cargoPrice'];
    returns = map['returns'];
    id = map['id'];
    brandName = map['brandName'];

    images = map['images'] as List<String>;
    //todo: get the image from server
*/

    // featureOptionIds = map['feature'] as List<String>;

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

  ResourceStatus<CategoryNode> categoryNode(Categories categories) =>
      categories.getNodeFromLastCategoryId(categoryId);

  @override
  String toString() {
    return 'Product{id: $id,\n'
        ' name: $name,\n'
        ' categoryId: $categoryId,\n'
        ' info: $info,\n'
        ' returns: $returns,\n'
        ' cargoPrice: $cargoPrice,\n'
        ' brandName: $brandName,\n'
        ' images: $images,\n'
        ' subProducts: $subProducts}\n';
  }
}

class SubProduct {
  final String id;
  final String productId;
  final String barcode;
  final DateTime addedDate;
  final DateTime modifiedDate;
  final int quantity;
  final double price;
  final double discount;
  final List<String> productFeatureOptionIds;

  SubProduct(
      {required this.id,
      required this.productId,
      required this.barcode,
      required this.addedDate,
      required this.modifiedDate,
      required this.quantity,
      required this.price,
      required this.discount,
      required this.productFeatureOptionIds});

  int get discountPercent => discount == 0 ? 0 : ((discount / price) * 100).toInt();

  bool get availableInStock => quantity != 0;

  double get priceAfterDiscounting => discount == 0 ? price : (price - discount);

  @override
  String toString() {
    return 'SubProduct{id: $id,\n'
        ' productId: $productId,\n'
        ' barcode: $barcode,\n'
        ' addedDate: $addedDate,\n'
        ' modifiedDate: $modifiedDate,\n'
        ' quantity: $quantity,\n'
        ' price: $price,\n'
        ' discount: $discount,\n'
        ' productFeatureOptionIds: $productFeatureOptionIds\n'
        '}\n';
  }
}

class SubProducts {
  late final List<SubProduct> _subProducts;

  SubProducts(this._subProducts);

  SubProducts.empty() {
    _subProducts = [];
  }

  bool get availableInStock => getIdealSubProduct.availableInStock;

  List<SubProduct> get get => _subProducts;

  SubProduct get getIdealSubProduct {
    if (_subProducts.isEmpty)
      throw NullDataException("Sub products have an empty list, couldn't get idealSubProduct");
    SubProduct? highDiscountedProduct = _subProducts.first;
    SubProduct lowPricedProduct = _subProducts.first;
    for (var subProduct in _subProducts) {
      final discountPercent = subProduct.discountPercent;
      final highDiscountPercent = highDiscountedProduct?.discountPercent;
      if (lowPricedProduct.price > subProduct.price) lowPricedProduct = subProduct;
      if (discountPercent == 0) continue;
      if (highDiscountedProduct == null ||
          highDiscountPercent == null ||
          highDiscountPercent < discountPercent) {
        highDiscountedProduct = subProduct;
        continue;
      }
    }
    if (highDiscountedProduct == null) {
      return lowPricedProduct;
    } else {
      return highDiscountedProduct;
    }
  }

 static List<SubProduct> getSubProductsWhichContainsOption(String optionId,
      List<SubProduct> subProductList) {
    return subProductList
            .where(
              (subProduct) => subProduct.productFeatureOptionIds.contains(optionId),
            )
            .toList();
  }

  @override
  String toString() {
    return 'SubProducts{_subProducts: $_subProducts}';
  }
}
