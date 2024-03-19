import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/data/models/movie_model.dart';
import 'package:movie_app/utils/exception/api_exception.dart';
import 'package:movie_app/utils/utilities.dart';

import '../../data/repositories/movie_repository.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;

  MovieDetailBloc({required this.movieRepository}) : super(MovieDetailState.initial()) {
    on<GetMovieImagesEvent>((event, emit) async {
      emit(state.copyWith(
        backdrops: const ApiResultStates(status: ApiResultStatus.loading),
      ));

      try {
        final res = await movieRepository.getMovieImages(event.id);
        final backdrops = res.backdrops.take(6).toList();

        emit(
          state.copyWith(
            backdrops: ApiResultStates(status: ApiResultStatus.success, data: backdrops),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(backdrops: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });

    on<GetMovieDetailEvent>((event, emit) async {
      emit(state.copyWith(detail: const ApiResultStates(status: ApiResultStatus.loading)));

      try {
        final res = await movieRepository.getMovieDetail(event.id);

        emit(
          state.copyWith(
            detail: ApiResultStates(status: ApiResultStatus.success, data: res),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(detail: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });
  }
}
