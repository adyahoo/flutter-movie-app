import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/config/exception/api_exception.dart';
import 'package:movie_app/presentation/bloc/api_result_state.dart';

import '../../../data/model/movie_model.dart';
import '../../../domain/repository/repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;

  MoviesBloc({required this.movieRepository}) : super(MoviesState.inital()) {
    on<AllMoviesFetched>((event, emit) async {
      emit(state.copyWith(status: ApiResultStatus.loading));

      try{
        final res = await movieRepository.getAllMovies();

        emit(state.copyWith(status: ApiResultStatus.success, movies: res.results));
      } on ApiException catch(e){
        emit(state.copyWith(status: ApiResultStatus.error, error: e));
      }
    });
  }
}
