import '../../sddklibrary/helper/Log.dart';

class Category {
  late final String id;
  late final String name;
  late final String superId ;
  late final int layer;


  Category(this.id, this.name, this.superId, this.layer);

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    superId = map['superId'];
    layer = map['layer'];
  }



  @override
  String toString() {
    return 'Category{id: $id, name: $name, superId: $superId, layer: $layer}';
  }
}
