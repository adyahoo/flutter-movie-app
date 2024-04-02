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

      try {
        Map<String, dynamic> queries = {
          "page": 1,
        };
        final res = await movieRepository.getAllMovies(queries: queries);

        emit(state.copyWith(status: ApiResultStatus.success, movies: res.results, currentPage: res.page, totalPage: res.totalPages));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ApiResultStatus.error, error: e));
      }
    });

    on<MoviesSearched>(
      (event, emit) async {
        emit(state.copyWith(status: ApiResultStatus.loading));

        try {
          Map<String, dynamic> queries = {
            "page": 1,
            "query": event.query,
          };
          final res = await movieRepository.searchMovies(queries);

          emit(state.copyWith(status: ApiResultStatus.success, movies: res.results, currentPage: res.page, totalPage: res.totalPages));
        } on ApiException catch (e) {
          emit(state.copyWith(status: ApiResultStatus.error, error: e));
        }
      },
    );

    on<MoviesFiltered>(
      (event, emit) async {
        emit(state.copyWith(status: ApiResultStatus.loading));

        try {
          Map<String, dynamic> queries = {
            "page": 1,
            "with_genres": event.genres.join(" |"),
          };
          final res = await movieRepository.getAllMovies(queries: queries);

          emit(state.copyWith(status: ApiResultStatus.success, movies: res.results, currentPage: res.page, totalPage: res.totalPages));
        } on ApiException catch (e) {
          emit(state.copyWith(status: ApiResultStatus.error, error: e));
        }
      },
    );

    on<MoreMoviesFetched>(
      (event, emit) async {
        emit(state.copyWith(isLoadMore: true));

        try {
          Map<String, dynamic> queries = {
            "page": event.page,
          };

          if (event.query != null && event.query != "") {
            queries["query"] = event.query;

            final res = await movieRepository.searchMovies(queries);
            final newList = [...state.movies!, ...res.results];
            emit(state.copyWith(isLoadMore: false, movies: newList, currentPage: res.page, totalPage: res.totalPages));

            return;
          }

          if (event.genres.isNotEmpty) {
            queries["with_genres"] = event.genres.join(" |");
          }

          final res = await movieRepository.getAllMovies(queries: queries);
          final newList = [...state.movies!, ...res.results];

          emit(state.copyWith(isLoadMore: false, movies: newList, currentPage: res.page, totalPage: res.totalPages));
        } on ApiException catch (e) {
          emit(state.copyWith(isLoadMore: false, error: e));
        }
      },
    );
  }
}
