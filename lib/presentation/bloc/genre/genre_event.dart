part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class GenreFetched extends GenreEvent {}

class GenreSearched extends GenreEvent {
  const GenreSearched({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class GenreResetted extends GenreEvent {}
