import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  final cache = const FlutterSecureStorage();

  static const CACHED_USER_ACCESS_TOKEN_KEY = "user_access_token";
  static const CACHED_USER_REFRESH_TOKEN_KEY = "user_refresh_token";
  static const CACHED_DEVICE_TOKEN_KEY = "user_device_token";

  Future<String?> getCachedAccessToken() =>
      cache.read(key: CACHED_USER_ACCESS_TOKEN_KEY);
  Future<String?> getCachedRefreshToken() =>
      cache.read(key: CACHED_USER_REFRESH_TOKEN_KEY);
  Future<String?> getCachedDeviceToken() =>
      cache.read(key: CACHED_DEVICE_TOKEN_KEY);

  Future<void> cacheAccessToken(String value) =>
      cache.write(key: CACHED_USER_ACCESS_TOKEN_KEY, value: value);
  Future<void> cacheRefreshToken(String value) =>
      cache.write(key: CACHED_USER_REFRESH_TOKEN_KEY, value: value);
  Future<void> cacheDeviceToken(String value) =>
      cache.write(key: CACHED_DEVICE_TOKEN_KEY, value: value);

  Future<void> clear() => cache.deleteAll();
}
