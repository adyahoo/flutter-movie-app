import 'package:dio/dio.dart';
import 'package:movie_app/app/data/models/api_model.dart';

class ApiException implements Exception {
  const ApiException({this.response, this.exception});

  final ApiResponse? response;
  final DioException? exception;

  static DioException parseError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      throw ApiException(response: ApiResponse.fromJson(e.response?.data), exception: e);
    }

    throw ApiException(response: null, exception: e);
  }
}
