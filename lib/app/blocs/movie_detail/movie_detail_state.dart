part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({this.backdrops, this.detail, this.credit, required this.status, this.error});

  final ApiResultStatus status;
  final ApiException? error;
  final List<ImageModel>? backdrops;
  final MovieDetailModel? detail;
  final MovieCreditModel? credit;

  factory MovieDetailState.initial() => const MovieDetailState(
        status: ApiResultStatus.init,
        detail: null,
        backdrops: null,
        credit: null,
        error: null,
      );

  MovieDetailState copyWith({
    ApiResultStatus? status,
    ApiException? error,
    List<ImageModel>? backdrops,
    MovieDetailModel? detail,
    MovieCreditModel? credit,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      error: error ?? this.error,
      backdrops: backdrops ?? this.backdrops,
      detail: detail ?? this.detail,
      credit: credit ?? this.credit,
    );
  }

  @override
  List<Object?> get props => [status, error, backdrops, detail, credit];
}
