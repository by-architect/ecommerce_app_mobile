import 'dart:ui';

import 'package:ecommerce_app_mobile/sddklibrary/helper/Helper.dart';

class ProductFeature {
  late final String id;
  late final String optionName;
  late final ProductFeatureType productFeatureType;
  late final List<ProductFeatureOption> options;

  ProductFeature(
    this.id,
    this.optionName,
    this.options,
    this.productFeatureType,
  );

  ProductFeature.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    optionName = map['name'];
    productFeatureType = ProductFeatureType.fromString(map['type']);
    options = (map['options'] as List<dynamic>)
        .map((option) => ProductFeatureOption(
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
      id ?? this.id,
      optionName ?? this.optionName,
      options ?? this.options,
      productFeatureType ?? this.productFeatureType,
    );
  }

  @override
  String toString() {
    return 'ProductFeature{id: $id, optionName: $optionName, productFeatureType: $productFeatureType, options: ${options.toString()}';
  }
}

enum ProductFeatureType {
  text,
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
