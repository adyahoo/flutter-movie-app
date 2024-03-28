part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  const MoviesState({
    required this.status,
    this.error,
    this.movies,
  });

  final ApiResultStatus status;
  final ApiException? error;
  final List<MovieModel>? movies;

  factory MoviesState.inital() => const MoviesState(status: ApiResultStatus.init);

  MoviesState copyWith({
    ApiResultStatus? status,
    ApiException? error,
    List<MovieModel>? movies,
  }) {
    return MoviesState(
      status: status ?? this.status,
      error: error ?? this.error,
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object?> get props => [status, error, movies];
}
