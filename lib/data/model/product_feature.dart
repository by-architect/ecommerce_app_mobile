import 'dart:ui';

import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';

class ProductFeature {
  late final String id;
  late final String name;
  late final ProductFeatureType productFeatureType;
  late final List<ProductFeatureOption> options;

  ProductFeature({
    required this.id,
    required this.name,
    required this.options,
    required this.productFeatureType,
  });

  ProductFeature.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    productFeatureType = ProductFeatureType.fromString(map['type']);
    options = (map['options'] as List<dynamic>)
        .map((option) =>
        ProductFeatureOption(
          option['id'].toString(),
          option['name'],
        ))
        .toList();
  }

  ProductFeature copyWith({
    String? id,
    String? optionName,
    ProductFeatureType? productFeatureType,
    List<ProductFeatureOption>? options,
  }) {
    return ProductFeature(
      id: id ?? this.id,
      name: optionName ?? this.name,
      options: options ?? this.options,
      productFeatureType: productFeatureType ?? this.productFeatureType,
    );
  }

  @override
  String toString() {
    return 'ProductFeature{id: $id, optionName: $name, productFeatureType: $productFeatureType, options: ${options
        .toString()}';
  }
}

enum ProductFeatureType {
  text,
  character,
  color;

  static ProductFeatureType fromString(String type) {
    if (type == "text") {
      return ProductFeatureType.text;
    } else {
      return ProductFeatureType.color;
    }
  }
}

class ProductFeatureOption {
  final String id;
  final String name;

  ProductFeatureOption(this.id, this.name);

  Color get color => Color(name.toInt);

  @override
  String toString() {
    return '_Option{id: $id, name: $name}';
  }
}

class ProductFeatures {
  late final List<ProductFeature> _productFeatures;

  ProductFeatures(this._productFeatures);

  ProductFeatures.empty() {
    _productFeatures = [];
  }

/*
  ProductFeatures.fromSubProduct(SubProduct subProduct) {
    _productFeatures = getProductFeaturesFromSubProduct(subProduct);
  }
*/

  bool get isEmpty => _productFeatures.isEmpty;

  int get length => _productFeatures.length;

  List<ProductFeature> get get => _productFeatures;

  bool isLastByIndex(int index) => index == length - 1;
  bool isLastByFeature(ProductFeature feature) => _productFeatures.last == feature;

/*
  List<ProductFeature> getProductFeaturesFromSubProduct(SubProduct subProduct) {
    List<ProductFeature> selectedFeatures = [];
    for (var productFeature in _productFeatures) {
      for (var option in productFeature.options) {
        if (subProduct.productFeatureOptionIds.contains(option.id)) {
          selectedFeatures.add(productFeature);
          break;
        }
      }
    }
    return selectedFeatures;
  }
*/
}

/*
class ProductFeatureWithSelectedOption {
  final ProductFeature productFeature;
  final ProductFeatureOption selectedOption;

  ProductFeatureWithSelectedOption(this.productFeature, this.selectedOption);

  @override
  String toString() {
    return 'ProductFeatureSelectedOption{productFeature: $productFeature, selectedOption: $selectedOption}';
  }
}
*/

/*
class ProductFeatureWithSelectedOptions {
  final ProductFeature productFeature;
  final List<ProductFeatureOption> selectedOptions;

  ProductFeatureWithSelectedOptions(this.productFeature, this.selectedOptions);

  ProductFeatureWithSelectedOptions copyWith({required List<ProductFeatureOption> selectedOptions}) {
    return ProductFeatureWithSelectedOptions(productFeature, selectedOptions);
  }

  @override
  String toString() {
    return 'ProductFeatureSelectedOptions{productFeature: $productFeature, selectedOption: $selectedOptions}';
  }
}
*/
