import 'category.dart';

class CategoryNode {
  late final List<Category> _node;

  CategoryNode(this._node);

  CategoryNode.empty() {
    _node = [];
  }

  String get nodeString => _categoryNodeToString(_node);

  List<Category> get node => _node;

  int get length => _node.length;
  Category get last => _node.last;
  Category get first => _node.first;

  add(Category category) => _node.add(category);

  removeLast() => _node.removeLast();

  String _categoryNodeToString(List<Category> categoryNode) {
    String nodeString = "";
    for (var category in categoryNode) {
      if (nodeString.isEmpty) {
        nodeString = category.name;
      } else {
        nodeString = "  $nodeString  >  ${category.name}";
      }
    }
    return nodeString;
  }

  @override
  String toString() {
    return 'CategoryNode{_node: $_node}';
  }
}
