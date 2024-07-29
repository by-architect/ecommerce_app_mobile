class ProductFeature {
  late final String id;
  late final String optionName;
  late final _ProductFeatureType productFeatureType;
  late final List<_Option> options;
  _Option? selectedOption;

  ProductFeature(this.id, this.optionName, this.options,this.productFeatureType);

  ProductFeature.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    optionName = map['name'];
    productFeatureType = _ProductFeatureType.fromString(map['type']);
    options = (map['options'] as List<dynamic>)
        .map((option) => _Option(
              option['id'].toString(),
              option['name'],
            ))
        .toList();
  }

  @override
  String toString() {
    return 'ProductFeature{id: $id, optionName: $optionName, productFeatureType: $productFeatureType, options: ${options.toString()}';
  }
}

enum _ProductFeatureType {
  text,
  color;

  static _ProductFeatureType fromString(String type) {
    if(type == "text") {
      return _ProductFeatureType.text;
    } else {
      return _ProductFeatureType.color;
    }
  }
}

class _Option {
  final String id;
  final String name;

  _Option(this.id, this.name);

  @override
  String toString() {
    return '_Option{id: $id, name: $name}';
  }
}
