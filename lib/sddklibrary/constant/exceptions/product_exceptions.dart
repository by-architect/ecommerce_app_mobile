class CategoryException implements Exception{
  final String message;

  CategoryException(this.message);
}

class CategoryNotFoundException implements Exception{
  final String _message;

  String get message => "Category Not Found: $_message";

  CategoryNotFoundException(this._message);
}