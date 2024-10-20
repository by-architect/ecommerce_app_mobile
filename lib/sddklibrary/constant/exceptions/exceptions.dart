class ExceptionBase implements Exception{}

class NullDataException implements ExceptionBase{
  final String message;

  NullDataException(this.message);

  @override
  String toString() {
    return "Null Data: $message";
  }
}

class NetworkDeviceDisconnectedException implements ExceptionBase {
  final String message;

  NetworkDeviceDisconnectedException(this.message,);

  @override
  String toString() {
    return "Network Error: $message";
  }
}

class UserNotAuthenticatedException implements ExceptionBase{
 final String message;

 UserNotAuthenticatedException(this.message);

 @override
  String toString() {
    return 'UserNotAuthenticatedException {message: $message}';
 }
}

class ValidationException implements ExceptionBase{
  final String message;

  ValidationException(this.message);

  @override
  String toString() {
    return 'ValidationException {message: $message}';
  }
}
