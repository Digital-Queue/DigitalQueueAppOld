import 'dart:io';
import 'dart:math';

import 'package:digital_queue/services/dtos/error_result.dart';
import 'package:digital_queue/services/dtos/profile_result.dart';
import 'package:dio/dio.dart';

import 'dtos/authentication_result.dart';

abstract class ApiResult {
  // TODO: marker abstract class

  ApiResult();

  factory ApiResult.ok() => OkResult();
}

class OkResult extends ApiResult {}

class ApiClientInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.resolve(
      Response(
        requestOptions: err.requestOptions,
        data: ErrorResult(
          message: err.message,
        ),
      ),
    );
  }
}

class ApiClient {
  final baseUrl = 'http://10.0.2.2:5241/api';
  late Dio client;

  Future<ApiResult> initialize() async {
    client = Dio(BaseOptions(baseUrl: baseUrl));
    client.interceptors.add(ApiClientInterceptor());

    var response = await client.get(
      "/",
    );

    if (response.statusCode != 200) {
      return response.data as ErrorResult;
    }

    return ApiResult.ok();
  }

  Future<ApiResult> authenticate(String email) async {
    var response = await client.post(
      "/accounts/authenticate",
      data: {
        "email": email,
      },
    );

    if (response.statusCode == 201) {
      return AuthenticationStatus(
        created: true,
      );
    }

    if (response.statusCode == 200) {
      return AuthenticationStatus();
    }

    return response.data as ErrorResult;
  }

  Future<ApiResult> verifyAuthenticationCode({
    required String email,
    required String code,
    String? deviceToken,
  }) async {
    var body = {
      "email": email,
      "code": code,
    };

    var response = await client.post(
      "/accounts/verify-authentication",
      data: body,
      options: Options(
        headers: {
          "X-Device-Token": deviceToken,
        },
      ),
    );

    if (response.statusCode != 200) {
      return response.data;
    }

    return AuthenticationResult(
      response.data['accessToken'],
      response.data['refreshToken'],
    );
  }

  Future<ApiResult> getProfile({
    required String accessToken,
  }) async {
    var response = await client.get(
      "/accounts/get-profile",
      options: Options(
        headers: {
          "authorization": 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 200) {
      return response.data as ErrorResult;
    }

    return ProfileResult(
      id: response.data["id"],
      name: response.data["name"],
      email: response.data["email"],
      createAt: response.data["createdAt"],
    );
  }

  Future<ApiResult?> refreshSession({
    required String refreshToken,
    String? deviceToken,
  }) async {
    final response = await client.patch(
      "/sessions/refresh-session",
      data: {
        "token": refreshToken,
      },
      options: Options(
        headers: {
          "X-Device-Token": deviceToken,
        },
      ),
    );

    if (response.statusCode != 200) {
      return response.data as ErrorResult;
    }

    return AuthenticationResult(
      response.data['accessToken'],
      response.data['refreshToken'],
    );
  }

  Future<ApiResult?> terminateSession({
    required String accessToken,
  }) async {
    final response = await client.post("/sessions/terminate-session",
        options: Options(headers: {
          "Authorization": "Bearer $accessToken",
        }));

    if (response.statusCode != 204) {
      return response.data as ErrorResult;
    }

    return ApiResult.ok();
  }

  Future<ApiResult> setName({
    required String name,
    required String accessToken,
  }) async {
    final response = await client.patch(
      "/accounts/set-name",
      data: {
        "name": name,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    if (response.statusCode != 204) {
      return response.data as ErrorResult;
    }

    return ApiResult.ok();
  }

  Future<ApiResult> requestChangeEmailCode({
    required String email,
    required String accessToken,
  }) async {
    final response = await client.post(
      "/accounts/request-email-change",
      data: {
        "email": email,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    if (response.statusCode != 204) {
      return response.data as ErrorResult;
    }

    return ApiResult.ok();
  }

  Future<ApiResult> verifyChangeEmailCode({
    required String email,
    required String code,
    required String accessToken,
  }) async {
    final response = await client.patch(
      "/accounts/change-email",
      data: {
        "email": email,
        "token": code,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    if (response.statusCode != 200) {
      return response.data as ErrorResult;
    }

    return ApiResult.ok();
  }
}
