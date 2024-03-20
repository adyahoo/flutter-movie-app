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
    on<FetchData>((event, emit) async {
      emit(state.copyWith(status: ApiResultStatus.loading));

      try {
        final detail = await movieRepository.getMovieDetail(event.id);

        final images = await movieRepository.getMovieImages(event.id);
        final backdrops = images.backdrops.take(6).toList();

        final credit = await movieRepository.getMovieCredit(event.id);

        emit(
          state.copyWith(
            status: ApiResultStatus.success,
            detail: detail,
            backdrops: backdrops,
            credit: credit,
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(status: ApiResultStatus.error, error: e));
      }
    });
  }
}
