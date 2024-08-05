import 'package:ecommerce_app_mobile/sddklibrary/helper/error.dart';

abstract class Resource<T> {
  T? get data;

  DefaultError? get error;

  bool get stable;

  const Resource();

  Status get status {
    if (this is ResourceStatus<T>) {
      final resourceSuccess = this as ResourceStatus<T>;
      return resourceSuccess.isSuccess ? Status.success : Status.fail;
    }
    if (stable) return Status.stable;
    return Status.loading;
  }

  factory Resource.loading() = Loading<T>;

  factory Resource.stable() = Stable<T>;

  factory Resource.success(T data) = ResourceStatus<T>.success;

  factory Resource.fail(DefaultError error) = ResourceStatus<T>.fail;
}

enum Status { success, fail, loading, stable }

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

  Fail(this._error);

  @override
  T? get data => null;

  @override
  DefaultError? get error => _error;

  @override
  bool get stable => false;
}

class Stable<T> extends Resource<T> {
  @override
  T? get data => null;

  @override
  DefaultError? get error => null;

  @override
  bool get stable => true;
}

class ResourceStatus<T> extends Resource<T> {
  final T? data;
  final DefaultError? error;

  const ResourceStatus.success(this.data) : error = null;

  const ResourceStatus.fail(this.error) : data = null;

  bool get isSuccess => data != null;

   ResourceStatus<T> onSuccess(Function(T data) successAction){
     if(isSuccess){
       successAction(data as T);
     }
     return this;
   }

  ResourceStatus<T> onFailure(Function(DefaultError fail) failAction){
    if(!isSuccess){
      failAction(error as DefaultError);
    }
    return this;
  }
  @override
  bool get stable => false;
}
