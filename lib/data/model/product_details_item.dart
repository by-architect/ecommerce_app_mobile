class ProductDetailsItem{
  final String title;
  final String content;

  ProductDetailsItem(this.title, this.content);

  @override
  String toString() {
    return 'ProductDetailsItem{title: $title, content: $content}';
  }
}