import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/constants.dart';

import '../../../config/di.dart';
import '../../data/services/service.dart';
import '../exception/api_exception.dart';

class ApiClient {
  static Dio instance() {
    final client = Dio();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Constants.ACCESS_TOKEN}',
    };

    client.options = BaseOptions(
      baseUrl: Constants.BASE_URL,
      headers: headers,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );

    if (kDebugMode) {
      client.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
      );
    }
    client.interceptors.add(ApiInterceptors());

    return client;
  }
}

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sessionId = inject<StorageService>().getSessionID();

    if (sessionId != null) {
      options.queryParameters.addAll({
        'session_id': sessionId,
      });
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}

typedef ClientReturn<T> = T Function();

Future<T> clientExecutor<T>({required ClientReturn<Future<T>> execute}) async {
  try {
    return await execute();
  } on DioException catch (e) {
    throw ApiException.parseError(e);
  } catch (e) {
    throw Exception(e);
  }
}
