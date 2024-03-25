part of 'rating_favorite_bloc.dart';

class RatingFavoriteState extends Equatable {
  const RatingFavoriteState({
    required this.status,
    this.ratedMovies,
    this.error,
  });

  final ApiResultStatus status;
  final ApiException? error;
  final ListApiResponse<RatedMovieModel>? ratedMovies;

  factory RatingFavoriteState.initial() => const RatingFavoriteState(status: ApiResultStatus.init);

  RatingFavoriteState copyWith({
    ApiResultStatus? status,
    ApiException? error,
    ListApiResponse<RatedMovieModel>? ratedMovies,
  }) {
    return RatingFavoriteState(
      status: status ?? this.status,
      error: error ?? this.error,
      ratedMovies: ratedMovies ?? this.ratedMovies,
    );
  }

  @override
  List<Object?> get props => [status, error, ratedMovies];
}
