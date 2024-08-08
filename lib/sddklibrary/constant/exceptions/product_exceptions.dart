class CategoryException implements Exception{
  final String message;

  CategoryException(this.message);


}

class CategoryNotFoundException implements CategoryException{
  final String _message;

  @override
  String get message => "Category Not Found: $_message";

  CategoryNotFoundException(this._message);

  @override
  String toString() {
    return message;
  }
}