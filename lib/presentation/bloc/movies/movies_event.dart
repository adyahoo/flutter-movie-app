part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class AllMoviesFetched extends MoviesEvent {
  const AllMoviesFetched();

  @override
  List<Object> get props => [];
}

class MoviesSearched extends MoviesEvent {
  const MoviesSearched({
    required this.query,
  });

  final String query;

  @override
  List<Object> get props => [query];
}

class MoviesFiltered extends MoviesEvent {
  MoviesFiltered({List<int>? genres}) : genres = genres ?? [];

  final List<int> genres;

  @override
  List<Object> get props => [genres];
}

class MoreMoviesFetched extends MoviesEvent {
  MoreMoviesFetched({required this.page, List<int>? genres, this.query}) : genres = genres ?? [];

  final int page;
  final List<int> genres;
  final String? query;

  @override
  List<Object?> get props => [page, genres, query];
}
