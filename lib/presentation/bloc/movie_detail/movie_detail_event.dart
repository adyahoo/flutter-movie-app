part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends MovieDetailEvent {
  const FetchData({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}

class MovieImagesFetched extends MovieDetailEvent {
  const MovieImagesFetched({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

class MovieRatingAdded extends MovieDetailEvent {
  const MovieRatingAdded({required this.id, required this.rateValue});

  final int id;
  final double rateValue;

  @override
  List<Object> get props => [id, rateValue];
}

class MovieRatingDeleted extends MovieDetailEvent {
  const MovieRatingDeleted({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class FavoriteToggled extends MovieDetailEvent {}
