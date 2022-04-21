import 'package:digital_queue/models/user.dart';

class ApiClient {
  final baseUrl = 'http://localhost:5241/api';

  void signIn(String email, String password) {}

  void signUp(User user, String password) {}

  void getProfile() {}

  void requestEmailConfirmation() {}

  void requestPasswordReset() {}

  void confirmEmail(String token) {}

  void resetPassword(String token, String password) {}

  void changeEmail(String email) {}
}
