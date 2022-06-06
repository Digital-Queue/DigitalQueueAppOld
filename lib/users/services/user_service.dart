import 'package:digital_queue/shared/services/backend_service.dart';
import 'package:digital_queue/shared/services/cache_service.dart';
import 'package:digital_queue/users/models/result.dart';
import 'package:digital_queue/users/models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserService extends BackendService {
  UserService({required CacheService cacheService})
      : super(cacheService: cacheService);

  Future<List<String>> getUserPermissions() async {
    final accessToken = await cacheService.getCachedAccessToken();
    if (accessToken == null) {
      return List.empty(growable: false);
    }

    final data = Jwt.parseJwt(accessToken);
    return data.keys.toList(growable: false);
  }

  Future<Result<User>> profile() async {
    final profileResponse = await send(
      path: "/accounts/get-profile",
      method: "GET",
      requireAuth: true,
    );

    if (profileResponse.error == true) {
      return Result.error(message: profileResponse.message);
    }

    final user = User(
      id: profileResponse.data["id"],
      name: profileResponse.data["name"],
      email: profileResponse.data["email"],
    );

    return Result.ok(data: user);
  }

  Future<Result> setName({required String name}) async {
    final response = await send(
      path: "/accounts/set-name",
      method: "PATCH",
      data: {
        "name": name,
      },
      requireAuth: true,
    );

    if (response.error == true) {
      return Result.error(message: "Something went wrong");
    }

    return Result.ok();
  }

  Future<Result> getChangeEmailToken({required String email}) async {
    final response = await send(
      path: "/accounts/request-email-change",
      method: "POST",
      data: {
        "email": email,
      },
      requireAuth: true,
    );

    if (response.error == true) {
      return Result.error(message: "Something went wrong");
    }

    return Result.ok();
  }

  Future<Result> changeEmail({
    required String email,
    required String code,
  }) async {
    final response = await send(
      path: "/accounts/change-email",
      method: "PATCH",
      data: {
        "email": email,
        "token": code,
      },
      requireAuth: true,
    );

    if (response.error == true) {
      return Result.error(message: "Something went wrong");
    }

    return Result.ok();
  }
}
