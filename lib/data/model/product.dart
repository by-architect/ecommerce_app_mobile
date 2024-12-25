import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import 'category_node.dart';
import 'money.dart';

class Product {
  final String id;
  final String name;
  final String categoryId;
  final String info;
  final String returns;
  final Money? cargoPrice;
  final String? brandName;
  final List<String> images;
  final SubProducts subProducts;
  final List<ProductFeature> features;
  final List<ProductDetailsItem> productDetails;

  String get firstImageOrEmpty => images.firstOrNull ?? "";

  String get brandNameOrEmpty => brandName ?? "";

  Product({
    required this.id,
    required this.productDetails,
    required this.name,
    required this.categoryId,
    required this.info,
    required this.cargoPrice,
    required this.returns,
    required this.images,
    required this.brandName,
    required this.subProducts,
    required this.features,
  });

  @TestOnly()
  factory Product.testOnly({
    required String id,
    required String name,
    required String categoryId,
    required String info,
    required String returns,
    required Money? cargoPrice,
    required String? brandName,
    required List<String> images,
    required SubProducts subProducts,
    required List<ProductDetailsItem> productDetails,
    required AllProductFeatures allProductFeatures,
  }) {
    return Product(
      id: id,
      name: name,
      categoryId: categoryId,
      info: info,
      cargoPrice: cargoPrice,
      returns: returns,
      images: images,
      productDetails: productDetails,
      subProducts: subProducts,
      brandName: brandName,
      features: allProductFeatures.getProductFeaturesFromSubProduct(subProducts.get.first),
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
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

  ResourceStatus<CategoryNode> categoryNode(Categories categories) => categories.getNodeFromLastCategoryId(categoryId);

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
  final Money price;
  final Money discount;
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

  bool get hasDiscount => !discount.isZero;

  int get discountPercent => !hasDiscount ? 0 : ((discount.amount / price.amount) * 100).toInt();

  bool get availableInStock => quantity != 0;

  Money get priceAfterDiscounting => !hasDiscount ? price : (price.subtract(discount));

  //todo: unimplemented
  factory SubProduct.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError("map unimplemented");
/*
    return SubProduct(
        id: map['id'],
        productId: map['productId'],
        barcode: map['barcode'],
        addedDate: map['addedDate'],
        modifiedDate: map['modifiedDate'],
        quantity: map['quantity'],
        price: map['price'],
        discount: map['discount'],
        productFeatureOptionIds: map['productFeatureOptionIds']);
*/
  }

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
    if (_subProducts.isEmpty) {
      throw NullDataException("Sub products have an empty list, couldn't get idealSubProduct");
    }
    SubProduct? highDiscountedProduct = _subProducts.first;
    SubProduct lowPricedProduct = _subProducts.first;
    for (var subProduct in _subProducts) {
      final discountPercent = subProduct.discountPercent;
      final highDiscountPercent = highDiscountedProduct?.discountPercent;
      if (lowPricedProduct.price.isGreaterThan(subProduct.price)) {
        lowPricedProduct = subProduct;
      }
      if (discountPercent == 0) continue;
      if (highDiscountedProduct == null || highDiscountPercent == null || highDiscountPercent < discountPercent) {
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

  static List<SubProduct> getSubProductsWhichContainsOption(String optionId, List<SubProduct> subProductList) {
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

/*
class ProductWithQuantity {
  final Product product;
  final SubProduct subProduct;
  final int quantity;

  ProductWithQuantity increaseQuantity() => ProductWithQuantity(product: product, subProduct: subProduct, quantity: quantity + 1);

  ProductWithQuantity decreaseQuantity() => ProductWithQuantity(product: product, subProduct: subProduct, quantity: quantity - 1);

  ProductWithQuantity({required this.product, required this.subProduct, required this.quantity});
}
*/
class ProductWithQuantity {
  final Product product;
  final SubProduct subProduct;
  final int quantity;

  ProductWithQuantity({required this.product, required this.subProduct, required this.quantity});

  ProductWithQuantity setQuantity(int quantity) => ProductWithQuantity(product: product, subProduct: subProduct, quantity: quantity);

  ProductWithQuantity increaseQuantity() => ProductWithQuantity(product: product, subProduct: subProduct, quantity: quantity + 1);

  ProductWithQuantity decreaseQuantity() => ProductWithQuantity(product: product, subProduct: subProduct, quantity: quantity - 1);

  factory ProductWithQuantity.fromMap(Map<String, dynamic> map) {
    return ProductWithQuantity(
      product: Product.fromMap(map['product']),
      subProduct: SubProduct.fromMap(map['subProduct']),
      quantity: map['quantity'],
    );
  }

  @override
  String toString() {
    return 'ProductWithQuantity{product: $product, subProduct: $subProduct, quantity: $quantity}';
  }
}
