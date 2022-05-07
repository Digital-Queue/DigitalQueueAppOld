import 'package:digital_queue/models/user.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:digital_queue/services/profile_result.dart';
import 'package:dio/dio.dart';

import 'authentication_result.dart';

abstract class ApiResult {
  // TODO: marker abstract class

  ApiResult();

  factory ApiResult.ok() => OkResult();
}

class OkResult extends ApiResult {}

class ApiClient {
  final baseUrl = 'http://10.0.2.2:5241/api';
  late Dio client;

  Future<ApiResult> initialize() async {
    client = Dio(BaseOptions(baseUrl: baseUrl));

    var response = await client.get(
      "/",
    );

    if (response.statusCode != 200) {
      return ErrorResult(
        message: getError(
          response,
        ),
      );
    }

    return OkResult();
  }

  String getError(Response response) {
    return response.data["message"] ?? "Something went wrong.";
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

    return ErrorResult(
      message: getError(
        response,
      ),
    );
  }

  Future<ApiResult> verifyAuthenticationCode(String email, String code) async {
    var body = {
      "email": email,
      "token": code,
    };

    var response = await client.post(
      "/accounts/verify-authentication",
      data: body,
    );

    if (response.statusCode != 200) {
      // TODO:
      return ErrorResult(
        message: getError(
          response,
        ),
      );
    }

    return AuthenticationResult(
      response.data.accessToken,
      response.data.refreshToken,
    );
  }

  Future<ApiResult> getProfile({required String accessToken}) async {
    var response = await client.get(
      "/accounts/get-profile",
      options: Options(
        headers: {"Authorization": "Bearer ${accessToken}"},
      ),
    );

    if (response.statusCode != 200) {
      // TODO:
      return ErrorResult(
        message: getError(
          response,
        ),
      );
    }

    return ProfileResult(
      id: response.data["id"],
      name: response.data["name"],
      email: response.data["email"],
      createAt: response.data["createdAt"],
    );
  }
}
