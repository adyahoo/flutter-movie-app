part of 'genre_bloc.dart';

class GenreState extends Equatable {
  const GenreState({
    required this.status,
    this.error,
    this.genres,
    this.filteredGenres,
  });

  final ApiResultStatus status;
  final ApiException? error;
  final List<GenreModel>? genres;
  final List<GenreModel>? filteredGenres;

  factory GenreState.initial() => const GenreState(status: ApiResultStatus.init);

  GenreState copyWith({
    ApiResultStatus? status,
    ApiException? error,
    List<GenreModel>? genres,
    List<GenreModel>? filteredGenres,
  }) {
    return GenreState(
      status: status ?? this.status,
      error: error ?? this.error,
      genres: genres ?? this.genres,
      filteredGenres: filteredGenres ?? this.filteredGenres,
    );
  }

  @override
  List<Object?> get props => [status, error, genres, filteredGenres];
}
