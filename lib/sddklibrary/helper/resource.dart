
import 'fail.dart';

abstract class Resource<T> {
  T? get data;

  Fail? get error;

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

  factory Resource.loading() = _Loading<T>;

  factory Resource.stable() = _Stable<T>;

  factory Resource.success(T data) = ResourceStatus<T>.success;

  factory Resource.fail(Fail error) = ResourceStatus<T>.fail;
}

enum Status { success, fail, loading, stable }

class _Loading<T> extends Resource<T> {
  const _Loading();

  @override
  T? get data => null;

  @override
  Fail? get error => null;

  @override
  bool get stable => false;
}

class _Success<T> extends Resource<T> {
  final T _data;

  const _Success(this._data);

  @override
  T? get data => _data;

  @override
  Fail? get error => null;

  @override
  bool get stable => false;
}

class _Fail<T> extends Resource<T> {
  final Fail _error;

  _Fail(this._error);

  @override
  T? get data => null;

  @override
  Fail? get error => _error;

  @override
  bool get stable => false;
}

class _Stable<T> extends Resource<T> {
  @override
  T? get data => null;

  @override
  Fail? get error => null;

  @override
  bool get stable => true;
}

class ResourceStatus<T> extends Resource<T> {
  final T? data;
  final Fail? error;

  const ResourceStatus.success(this.data) : error = null;

  const ResourceStatus.fail(this.error) : data = null;

  bool get isSuccess => data != null;

   ResourceStatus<T> onSuccess(Function(T data) successAction){
     if(isSuccess){
       successAction(data as T);
     }
     return this;
   }

  ResourceStatus<T> onFailure(Function(Fail fail) failAction){
    if(!isSuccess){
      failAction(error as Fail);
    }
    return this;
  }
  @override
  bool get stable => false;
}
