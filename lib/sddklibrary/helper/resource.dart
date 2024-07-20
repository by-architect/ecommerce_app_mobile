import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';

abstract class Resource<T> {
  T? get data;

  DefaultError? get error;

  bool get stable;

  const Resource();

  Status get status {
    if (error != null) {
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
  factory Resource.fail(DefaultError exception) = Fail<T>;
  factory Resource.stable() = Stable<T>;
}

enum Status { success, fail, loading ,stable}

class Loading<T> extends Resource<T> {
  const Loading();

  @override
  T? get data => null;

  @override
  DefaultError? get error => null;

  @override
  bool get stable => false;
}

class Success<T> extends Resource<T> {
  final T _data;

  const Success(this._data);

  @override
  T? get data => _data;

  @override
  DefaultError? get error => null;

  @override
  bool get stable => false;
}

class Fail<T> extends Resource<T> {
  final DefaultError _error;

  Fail(this._error){
    // Log.test("Resource",message: _message);
  }

  @override
  T? get data => null;

  @override
  DefaultError? get error =>_error ;

  @override
  bool get stable => false;
}

class Stable<T> extends Resource<T>{

  @override
  T? get data => null;

  @override
  DefaultError? get error => null;

  @override
  bool get stable => true;
}