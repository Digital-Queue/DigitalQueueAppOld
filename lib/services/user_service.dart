import 'package:digital_queue/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final storage = const FlutterSecureStorage();

  Future<User?> getUser() async {
    final userAccessToken = await storage.read(key: 'user_access_token');
    final userRefreshToken = await storage.read(key: 'user_refresh_token');

    if (userAccessToken == null || userRefreshToken == null) {
      return null;
    }

    final userId = await storage.read(key: 'user_id');
    final userName = await storage.read(key: 'user_name');
    final userEmail = await storage.read(key: 'user_email');
    final userDeviceToken = await storage.read(key: 'user_device_token');

    return User(
      id: userId,
      name: userName,
      email: userEmail,
      deviceToken: userDeviceToken,
      accessToken: userAccessToken,
      refreshToken: userRefreshToken,
    );
  }

  Future saveUser(User user) async {
    if (user.accessToken != null) {
      await storage.write(key: 'user_access_token', value: user.accessToken);
    }

    if (user.refreshToken != null) {
      await storage.write(key: 'user_refresh_token', value: user.refreshToken);
    }

    if (user.email != null) {
      await storage.write(key: 'user_email', value: user.email);
    }

    if (user.deviceToken != null) {
      await storage.write(key: 'user_device_token', value: user.deviceToken);
    }

    if (user.id != null) {
      await storage.write(key: 'user_id', value: user.id);
    }
  }
}
