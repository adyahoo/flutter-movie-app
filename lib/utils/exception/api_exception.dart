import 'package:dio/dio.dart';
import 'package:movie_app/app/data/models/error_model.dart';

class ApiException implements Exception {
  const ApiException({this.response, this.exception});

  final ErrorResponse? response;
  final DioException? exception;

  static DioException parseError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      throw ApiException(response: ErrorResponse.fromJson(e.response?.data), exception: e);
    }

    throw ApiException(response: null, exception: e);
  }
}
