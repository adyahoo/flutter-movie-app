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

class GetMovieImagesEvent extends MovieDetailEvent {
  const GetMovieImagesEvent({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

class GetMovieDetailEvent extends MovieDetailEvent {
  const GetMovieDetailEvent({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
