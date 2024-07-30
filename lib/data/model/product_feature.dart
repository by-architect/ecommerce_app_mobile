class ProductFeature {
  late final String id;
  late final String optionName;
  late final ProductFeatureType productFeatureType;
  late final List<ProductFeatureOption> options;
  ProductFeatureOption? selectedOption;

  ProductFeature(this.id, this.optionName, this.options, this.productFeatureType, {this.selectedOption});

  ProductFeature.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    optionName = map['name'];
    productFeatureType = ProductFeatureType.fromString(map['type']);
    options = (map['options'] as List<dynamic>)
        .map((option) =>
        ProductFeatureOption(
          option['id'].toString(),
          option['name'],
        ))
        .toList();
  }

  ProductFeature copyWith({String? id, String? optionName, ProductFeatureType? productFeatureType, List<
      ProductFeatureOption>? options, ProductFeatureOption? selectedOption}) {
    return ProductFeature(
        id ?? this.id,
        optionName ?? this.optionName,
        options ?? this.options,
        productFeatureType ?? this.productFeatureType,
      selectedOption: selectedOption ?? this.selectedOption
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

  @override
  String toString() {
    return '_Option{id: $id, name: $name}';
  }
}
