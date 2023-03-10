import 'dart:developer';

import 'package:digital_queue/shared/models/backend_response.dart';
import 'package:digital_queue/shared/services/cache_service.dart';
import 'package:dio/dio.dart';

class DioClientInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(err.message!, stackTrace: err.stackTrace);
    handler.resolve(
      Response(
        requestOptions: err.requestOptions,
        statusCode: err.response?.statusCode,
        data: BackendResponse.createError(
          message: err.response?.data["message"] ?? err.message,
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
  final CacheService cacheService;
  final baseUrl = const String.fromEnvironment(
    "API_BASE_URL",
    defaultValue: 'http://10.0.2.2:5241/api',
  );

  late final Dio client;

  BackendService({required this.cacheService}) {
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
      final accessToken = await cacheService.getCachedAccessToken();
      final customHeaders = {
        "Authorization": "Bearer $accessToken",
      };
      headers.addAll(customHeaders);
    }

    try {
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
    } on DioError catch (e) {
      return BackendResponse.createError(message: e.message!);
    }
  }
}
