import 'package:digital_queue/services/api_client.dart';

class ProfileResult extends ApiResult {
  late String id;
  late String email;
  late String name;
  late String createAt;

  ProfileResult({
    required this.id,
    required this.name,
    required this.email,
    required this.createAt,
  });
}
