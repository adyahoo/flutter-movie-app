part of 'rating_favorite_bloc.dart';

abstract class RatingFavoriteEvent extends Equatable {
  const RatingFavoriteEvent();

  @override
  List<Object?> get props => [];
}

class RatedMoviesFetched extends RatingFavoriteEvent {}
class FavoritedMoviesFetched extends RatingFavoriteEvent {}
