class Category {
  late final String id;
  late final String name;

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
