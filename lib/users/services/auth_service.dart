import 'package:digital_queue/shared/services/backend_service.dart';
import 'package:digital_queue/shared/services/cache_service.dart';
import 'package:digital_queue/users/models/result.dart';
import 'package:digital_queue/users/models/token.dart';

class AuthService extends BackendService {
  AuthService({required CacheService cacheService})
      : super(cacheService: cacheService);

  Future<Result<Token>> authenticate() async {
    final accessToken = await cacheService.getCachedAccessToken();
    final refreshToken = await cacheService.getCachedRefreshToken();

    if (accessToken == null || refreshToken == null) {
      return Result.error(message: "Unable to authentication");
    }

    final deviceToken = await cacheService.getCachedDeviceToken();

    final authenticationResponse = await send(
      path: "/sessions/refresh-session",
      method: "PATCH",
      data: {
        "token": refreshToken,
      },
      headers: {
        "X-Device-Token": deviceToken,
      },
    );

    if (authenticationResponse.error == true) {
      return Result.error(message: "Authentication failed");
    }

    final token = Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    return Result.ok(data: token);
  }

  Future<Result> getAuthenticationCode({
    required String email,
    String? deviceToken,
  }) async {
    final response = await send(
      path: "/accounts/authenticate",
      method: "POST",
      data: {
        "email": email,
      },
      headers: {
        "X-Device-Token": deviceToken,
      },
    );

    if (response.error == true) {
      return Result.error(message: response.message);
    }

    return Result.ok(
        data: {"status": response.statusCode == 201 ? "created" : "returning"});
  }

  Future<Result<Token>> verifyAuthenticationCode({
    required String email,
    required String code,
    String? deviceToken,
  }) async {
    var verificationResponse = await send(
      path: "/accounts/verify-authentication",
      method: "POST",
      data: {
        "email": email,
        "code": code,
      },
      headers: {
        "X-Device-Token": deviceToken,
      },
    );

    if (verificationResponse.error == true) {
      return Result.error(message: "Authentication error");
    }

    final accessToken = verificationResponse.data["accessToken"];
    final refreshToken = verificationResponse.data["refreshToken"];

    await cacheService.cacheAccessToken(accessToken);
    await cacheService.cacheRefreshToken(refreshToken);

    return Result.ok(
      data: Token(accessToken: accessToken, refreshToken: refreshToken),
    );
  }

  Future<Result> logout() async {
    // delete remote session data
    final logoutResponse = await send(
      path: "/sessions/terminate-session",
      method: "POST",
      requireAuth: true,
    );

    if (logoutResponse.error == true) {
      return Result.error(message: "Something went wrong");
    }

    // delete cache
    await cacheService.clear();

    return Result.ok();
  }
}
