part of 'detail_list_bloc.dart';

abstract class DetailListEvent extends Equatable {
  const DetailListEvent();

  @override
  List<Object> get props => [];
}

class DetailListFetched extends DetailListEvent {
  final int id;

  const DetailListFetched({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class DetailListCleared extends DetailListEvent {
  final int id;

  const DetailListCleared({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class AccountStateFetched extends DetailListEvent {
  final int movieId;

  const AccountStateFetched({
    required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}

class RatingAdded extends DetailListEvent {
  final int movieId;
  final double rate;

  const RatingAdded({
    required this.movieId,
    required this.rate,
  });

  @override
  List<Object> get props => [movieId, rate];
}

class RatingDeleted extends DetailListEvent {
  final int movieId;

  const RatingDeleted({
    required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}

class MovieFavorited extends DetailListEvent {
  final int id;
  final bool isFavorite;

  const MovieFavorited({
    required this.id,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [id, isFavorite];
}
