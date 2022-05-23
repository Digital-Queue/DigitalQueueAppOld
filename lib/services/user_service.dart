import 'dart:developer';

import 'package:digital_queue/models/user.dart';
import 'package:digital_queue/services/backend_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserService extends BackendService {
  Future<BackendResponse?> initialize() async {
    var response = await send(path: "/", method: "GET");
    if (response.error == true) {
      return response;
    }

    // verify for any stored session
    final accessToken = await cache.read(key: 'user_access_token');
    final refreshToken = await cache.read(key: 'user_refresh_token');
    if (accessToken == null || refreshToken == null) {
      // session not found
      return null;
    }

    // firebase
    var deviceToken = await cache.read(key: 'user_device_token');
    deviceToken ??= await FirebaseMessaging.instance.getToken();

    // refresh found session
    response = await refreshAuth(
      refreshToken: refreshToken,
      deviceToken: deviceToken,
    );

    return response;
  }

  Future<bool> isTeacherUser() async {
    final accessToken = await cache.read(key: 'user_access_token');
    if (accessToken == null) {
      return false;
    }

    final data = Jwt.parseJwt(accessToken);

    final hasTeacherClaim = data.keys.any((element) => element == 'teacher');
    return hasTeacherClaim;
  }

  Future<BackendResponse> refreshAuth({
    required String refreshToken,
    String? deviceToken,
  }) async {
    final response = await send(
      path: "/sessions/refresh-session",
      method: "PATCH",
      data: {
        "token": refreshToken,
      },
      headers: {
        "X-Device-Token": deviceToken,
      },
    );

    if (response.error == true) {
      return response;
    }

    // update token
    await cache.write(
        key: 'user_access_token', value: response.data["accessToken"]);
    await cache.write(
        key: 'user_refresh_token', value: response.data["refreshToken"]);

    return response;
  }

  Future<BackendResponse> createAuth({
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

    return response;
  }

  Future<BackendResponse> verifyAuth({
    required String email,
    required String code,
    String? deviceToken,
  }) async {
    var response = await send(
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

    if (response.error == null) {
      // update token
      await cache.write(
          key: 'user_access_token', value: response.data["accessToken"]);
      await cache.write(
          key: 'user_refresh_token', value: response.data["refreshToken"]);
    }

    return response;
  }

  Future<BackendResponse?> logout() async {
    BackendResponse? response;
    try {
      // delete remote session data
      response = await send(
        path: "/sessions/terminate-session",
        method: "POST",
        requireAuth: true,
      );
    } catch (error) {
      log(error.toString());
    }

    // delete cache
    await cache.deleteAll();

    return response;
  }

  Future<BackendResponse> profile() async {
    final accessToken = await cache.read(key: 'user_access_token');
    final response = await send(
      path: "/accounts/get-profile",
      method: "GET",
      requireAuth: true,
    );

    if (response.error == true) {
      return response;
    }

    final refreshToken = await cache.read(key: 'user_refresh_token');
    final deviceToken = await cache.read(key: 'user_device_token');

    final user = User(
      id: response.data["id"],
      name: response.data["name"],
      email: response.data["email"],
      accessToken: accessToken,
      refreshToken: refreshToken,
      deviceToken: deviceToken,
    );

    return BackendResponse(data: user);
  }

  Future<BackendResponse> updateName({required String name}) async {
    final response = await send(
      path: "/accounts/set-name",
      method: "PATCH",
      data: {
        "name": name,
      },
      requireAuth: true,
    );

    return response;
  }

  Future<BackendResponse> getChangeEmailToken({required String email}) async {
    final response = await send(
      path: "/accounts/request-email-change",
      method: "POST",
      data: {
        "email": email,
      },
      requireAuth: true,
    );

    return response;
  }

  Future<BackendResponse> changeEmail(
      {required String email, required String code}) async {
    final response = await send(
      path: "/accounts/change-email",
      method: "PATCH",
      data: {
        "email": email,
        "token": code,
      },
      requireAuth: true,
    );

    return response;
  }
}
