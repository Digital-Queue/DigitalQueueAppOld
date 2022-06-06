class BackendResponse {
  late final dynamic data;
  late final int? statusCode;

  late final bool? error;
  late final String? message;
  late final String? stacktrace;

  BackendResponse({
    this.data,
    this.statusCode,
    this.error,
    this.message,
    this.stacktrace,
  });

  factory BackendResponse.createError({
    required String message,
    String? stackTrace,
  }) =>
      BackendResponse(
        error: true,
        message: message,
        stacktrace: stackTrace,
      );

  factory BackendResponse.createResponse({
    required dynamic data,
    required int statusCode,
  }) =>
      BackendResponse(data: data, statusCode: statusCode);
}
