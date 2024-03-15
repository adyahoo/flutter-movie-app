import 'package:equatable/equatable.dart';
import 'package:movie_app/utils/exception/api_exception.dart';

abstract class ApiResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading<T> extends ApiResultState {}

class Success<T> extends ApiResultState {
  Success(this.response);

  final dynamic response;

  @override
  List<Object?> get props => [response];
}

class Error<T> extends ApiResultState {
  Error(this.e);

  final ApiException e;

  @override
  List<Object?> get props => [e];
}

enum ApiResultStatus { init, loading, success, error }

class ApiResultStates<T> extends Equatable {
  const ApiResultStates({required this.status, this.data, this.error});

  final T? data;
  final ApiResultStatus status;
  final ApiException? error;

  @override
  List<Object?> get props => [data, status, error];
}
