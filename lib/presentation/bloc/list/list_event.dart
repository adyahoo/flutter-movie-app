part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class MovieListFetched extends ListEvent {}

class MovieAddedToList extends ListEvent {
  const MovieAddedToList({required this.listId, required this.movieId});

  final int listId;
  final int movieId;

  @override
  List<Object> get props => [listId, movieId];
}
