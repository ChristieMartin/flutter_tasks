class ApiException implements Exception {
  final String? msg;

  const ApiException([this.msg]);

  @override
  String toString() => msg ?? "ApiException";
}

class RssException extends ApiException {
  @override
  const RssException([String? msg]);

  @override
  String toString() => msg ?? "RssException";
}
