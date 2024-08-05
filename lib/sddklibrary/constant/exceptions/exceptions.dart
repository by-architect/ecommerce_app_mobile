class NullDataException implements Exception{
  final String message;

  NullDataException(this.message);
}

class NetworkDeviceDisconnectedException implements Exception {
  final String message;

  NetworkDeviceDisconnectedException(this.message,);

  @override
  String toString() {
    return "Network Error: $message";
  }
}

