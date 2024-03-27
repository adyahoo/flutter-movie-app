import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/config/exception/api_exception.dart';
import 'package:movie_app/presentation/bloc/api_result_state.dart';

import '../../../data/model/movie_model.dart';
import '../../../domain/repository/repository.dart';

part 'list_event.dart';

part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListRepository listRepository;

  ListBloc({required this.listRepository}) : super(ListState.initial()) {
    on<MovieListFetched>((event, emit) async {
      emit(state.copyWith(status: ApiResultStatus.loading));

      try {
        final res = await listRepository.getList();

        emit(state.copyWith(status: ApiResultStatus.success, movieList: res.results));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ApiResultStatus.error, error: e));
      }
    });

    on<MovieAddedToList>(
      (event, emit) async {
        emit(state.copyWith(submitStatus: ApiResultStatus.loading));

        try {
          await listRepository.addMovie(event.listId, event.movieId);

          emit(state.copyWith(submitStatus: ApiResultStatus.success));
        } on ApiException catch (e) {
          emit(state.copyWith(submitStatus: ApiResultStatus.error, error: e));
        }
      },
    );
  }
}
