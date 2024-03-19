part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({required this.backdrops, required this.detail});

  final ApiResultStates<List<ImageModel>> backdrops;
  final ApiResultStates<MovieDetailModel> detail;

  factory MovieDetailState.initial() => const MovieDetailState(
        backdrops: ApiResultStates(status: ApiResultStatus.init),
        detail: ApiResultStates(status: ApiResultStatus.init),
      );

  MovieDetailState copyWith({
    ApiResultStates<List<ImageModel>>? backdrops,
    ApiResultStates<MovieDetailModel>? detail,
  }) {
    return MovieDetailState(
      backdrops: backdrops ?? this.backdrops,
      detail: detail ?? this.detail,
    );
  }

  @override
  List<Object?> get props => [backdrops];
}
