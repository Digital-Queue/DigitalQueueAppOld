class Result<T> {
  final String? message;
  final bool error;
  final T? data;

  Result({required this.error, this.message, this.data});

  factory Result.error({String? message}) {
    return Result(error: true, message: message);
  }

  factory Result.ok({T? data}) {
    return Result(error: false, data: data);
  }
}
