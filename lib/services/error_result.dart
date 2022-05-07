import 'package:digital_queue/services/api_client.dart';

class ErrorResult extends ApiResult {
  late String message;
  ErrorResult({
    required this.message,
  });
}
