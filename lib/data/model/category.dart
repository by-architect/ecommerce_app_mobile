import 'package:ecommerce_app_mobile/sddklibrary/annotation/test_annotation.dart';

import '../../sddklibrary/util/Log.dart';

class Category {
  late final String id;
  late final String name;
  late final String superId;

  late final int layer;

  Category({required this.id, required this.name, required this.superId, required this.layer});

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    superId = map['superId'];
    layer = map['layer'];
  }

  @TestOnly()
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'superId': superId,
      'layer': layer,
    };
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, superId: $superId, layer: $layer}';
  }
}
