import 'dart:ui';

import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';
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
    options = (map['options'] as List<dynamic>).map((option) => ProductFeatureOption.fromMap(option)).toList();
  }

  @TestOnly()
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': productFeatureType.toStringValue,
      'options': options.map((option) => option.toMap()).toList(),
    };
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
    return 'ProductFeature{id: $id, optionName: $name, productFeatureType: $productFeatureType, options: ${options.toString()}';
  }
}

enum ProductFeatureType {
  text,
  character,
  color;

  @TestOnly()
  String get toStringValue {
    if (this == ProductFeatureType.color) {
      return "color";
    }
    if (this == ProductFeatureType.character) {
      return "character";
    } else {
      return "text";
    }
  }

  static ProductFeatureType fromString(String type) {
    if (type == "color") {
      return ProductFeatureType.color;
    }
    if (type == "character") {
      return ProductFeatureType.character;
    } else {
      return ProductFeatureType.text;
    }
  }
}

class ProductFeatureOption {
  final String id;
  final String name;

  ProductFeatureOption(this.id, this.name);

  Color get color => Color(name.toInt);

  bool get isColor => name.isHexColor;

  factory ProductFeatureOption.fromMap(Map<String, dynamic> map) {
    return ProductFeatureOption(map['id'], map['name']);
  }

  @TestOnly()
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return '_Option{id: $id, name: $name}';
  }
}

class AllProductFeatures {
  late final List<ProductFeature> _productFeatures;

  AllProductFeatures(this._productFeatures);

  AllProductFeatures.empty() {
    _productFeatures = [];
  }

  bool get isEmpty => _productFeatures.isEmpty;

  int get length => _productFeatures.length;

  bool isLastByIndex(int index) => index == _productFeatures.length - 1;

  List<ProductFeature> get get => _productFeatures;

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
}
