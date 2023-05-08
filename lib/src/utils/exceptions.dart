class ServerException implements Exception {
  final String exception;

  ServerException(this.exception);

  @override
  String toString() => exception;
}
