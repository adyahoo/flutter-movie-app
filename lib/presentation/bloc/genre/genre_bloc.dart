import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/config/exception/api_exception.dart';

import '../../../data/model/movie_model.dart';
import '../../../domain/repository/genre_repository.dart';
import '../api_result_state.dart';

part 'genre_event.dart';

part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository genreRepository;

  GenreBloc({required this.genreRepository}) : super(GenreState.initial()) {
    on<GenreFetched>(
      (event, emit) async {
        emit(state.copyWith(status: ApiResultStatus.loading));

        try {
          final res = await genreRepository.getMovieGenres();

          emit(state.copyWith(status: ApiResultStatus.success, genres: res, filteredGenres: res));
        } on ApiException catch (e) {
          emit(state.copyWith(status: ApiResultStatus.error, error: e));
        }
      },
    );

    on<GenreSearched>(
      (event, emit) {
        final filteredGenres = state.genres?.where((e) => e.name.toLowerCase().contains(event.query.toLowerCase())).toList();

        emit(state.copyWith(filteredGenres: filteredGenres));
      },
    );

    on<GenreResetted>(
          (event, emit) {
        emit(state.copyWith(filteredGenres: state.genres));
      },
    );
  }
}
