import 'package:digital_queue/services/api_client.dart';

class AuthenticationResult extends ApiResult {
  late String accessToken;
  late String refreshToken;

  AuthenticationResult(this.accessToken, this.refreshToken);
}

class AuthenticationStatus extends ApiResult {
  late bool created;
  AuthenticationStatus({this.created = false});
}
