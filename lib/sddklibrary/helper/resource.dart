import 'package:ecommerce_app_mobile/sddklibrary/helper/Log.dart';

abstract class Resource<T> {
  T? get data;

  String? get message;

  bool get stable;

  const Resource();

  Status get status {
    if (message != null) {
      return Status.fail;
    }
    if (data != null) {
      return Status.success;
    }
    if(stable) return Status.stable;
    return Status.loading;
  }


  factory Resource.loading() = Loading<T>;
  factory Resource.success(T data) = Success<T>;
  factory Resource.fail(String message) = Fail<T>;
  factory Resource.stable() = Stable<T>;
}

enum Status { success, fail, loading ,stable}

class Loading<T> extends Resource<T> {
  const Loading();

  @override
  T? get data => null;

  @override
  String? get message => null;

  @override
  bool get stable => false;
}

class Success<T> extends Resource<T> {
  final T _data;

  const Success(this._data);

  @override
  T? get data => _data;

  @override
  String? get message => null;

  @override
  bool get stable => false;
}

class Fail<T> extends Resource<T> {
  final String _message;

  Fail(this._message){
    Log.test("Resource",message: _message);
  }

  @override
  T? get data => null;

  @override
  String? get message => _message;

  @override
  bool get stable => false;
}

class Stable<T> extends Resource<T>{

  @override
  T? get data => null;

  @override
  String? get message => null;

  @override
  bool get stable => true;
}