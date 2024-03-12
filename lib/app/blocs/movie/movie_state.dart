part of 'movie_bloc.dart';

abstract class MovieState extends ApiResultState {
  MovieState();
}

class MovieInitial extends MovieState {}

class Popular extends MovieState {}

class NowPlaying extends MovieState {}

class TopRated extends MovieState {}

class Latest extends MovieState {}
