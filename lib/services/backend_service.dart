import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClientInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(err.message, stackTrace: err.stackTrace);
    handler.resolve(
      Response(
        requestOptions: err.requestOptions,
        statusCode: err.response?.statusCode,
        data: BackendResponse.createError(
          message: err.message,
        ),
      ),
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.resolve(
      Response(
        requestOptions: response.requestOptions,
        data: BackendResponse(
          data: response.data,
          statusCode: response.statusCode,
        ),
      ),
    );
  }
}

class BackendService {
  final cache = const FlutterSecureStorage();
  final baseUrl = const String.fromEnvironment(
    "API_BASE_URL",
    defaultValue: 'http://10.0.2.2:5241/api',
  );
  late final Dio client;

  BackendService() {
    client = Dio(BaseOptions(baseUrl: baseUrl));
    client.interceptors.add(DioClientInterceptor());
  }

  Future<BackendResponse> send({
    required String path,
    required String method,
    dynamic data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    bool requireAuth = false,
  }) async {
    if (requireAuth) {
      headers ??= {};
      final accessToken = await cache.read(key: 'user_access_token');
      final customHeaders = {
        "Authorization": "Bearer $accessToken",
      };
      headers.addAll(customHeaders);
    }

    final response = await client.request(
      path,
      data: data,
      queryParameters: params,
      options: Options(
        method: method,
        headers: headers,
      ),
    );

    return response.data as BackendResponse;
  }
}

class BackendResponse {
  late final dynamic data;
  late final int? statusCode;

  late final bool? error;
  late final String? message;
  late final String? stacktrace;

  BackendResponse({
    this.data,
    this.statusCode,
    this.error,
    this.message,
    this.stacktrace,
  });

  factory BackendResponse.createError({
    required String message,
    String? stackTrace,
  }) =>
      BackendResponse(
        error: true,
        message: message,
        stacktrace: stackTrace,
      );

  factory BackendResponse.createResponse({
    required dynamic data,
    required int statusCode,
  }) =>
      BackendResponse(data: data, statusCode: statusCode);
}
