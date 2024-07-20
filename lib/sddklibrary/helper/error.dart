
class DefaultError{
  final String userMessage;
  final String? exception;
  final String? errorCode;
  final String? location;
  final DateTime? dateTime;

  DefaultError({required this.userMessage,this.exception , this.errorCode, this.location , this.dateTime });
}