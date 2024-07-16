abstract class Resource<T> {
  T? get data;

  String? get message;

  const Resource();

  Status get status {
    if (message != null) {
      return Status.fail;
    }
    if (data != null) {
      return Status.success;
    }
    return Status.loading;
  }


  factory Resource.loading() = Loading<T>;
  factory Resource.success(T data) = Success<T>;
  factory Resource.fail(String message) = Fail<T>;
}

enum Status { success, fail, loading }

class Loading<T> extends Resource<T> {
  const Loading();

  @override
  T? get data => null;

  @override
  String? get message => null;
}

class Success<T> extends Resource<T> {
  final T _data;

  const Success(this._data);

  @override
  T? get data => _data;

  @override
  String? get message => null;
}

class Fail<T> extends Resource<T> {
  final String _message;

  const Fail(this._message);

  @override
  T? get data => null;

  @override
  String? get message => _message;
}