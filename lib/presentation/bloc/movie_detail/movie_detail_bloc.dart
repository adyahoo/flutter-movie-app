import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/exception/api_exception.dart';
import '../../../data/model/movie_model.dart';
import '../../../domain/repository/repository.dart';
import '../api_result_state.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;

  MovieDetailBloc({required this.movieRepository}) : super(MovieDetailState.initial()) {
    on<FetchData>(
      (event, emit) async {
        emit(state.copyWith(status: ApiResultStatus.loading));

        try {
          final detail = await movieRepository.getMovieDetail(event.id);

          final images = await movieRepository.getMovieImages(event.id);
          final backdrops = images.backdrops.take(6).toList();

          final credit = await movieRepository.getMovieCredit(event.id);

          final accountState = await movieRepository.getAccountStates(event.id);

          emit(state.copyWith(status: ApiResultStatus.success, detail: detail, backdrops: backdrops, credit: credit, accountState: accountState));
        } on ApiException catch (e) {
          emit(state.copyWith(status: ApiResultStatus.error, error: e));
        }
      },
    );

    on<MovieRatingAdded>(
      (event, emit) async {
        emit(state.copyWith(rateStatus: ApiResultStatus.loading));

        try {
          await movieRepository.addRating(event.id, event.rateValue);

          final accountState = await movieRepository.getAccountStates(event.id);

          emit(state.copyWith(rateStatus: ApiResultStatus.success, accountState: accountState));
        } on ApiException catch (e) {
          emit(state.copyWith(rateStatus: ApiResultStatus.error, error: e));
        }
      },
    );

    on<MovieRatingDeleted>(
      (event, emit) async {
        emit(state.copyWith(rateStatus: ApiResultStatus.loading));

        try {
          await movieRepository.deleteRating(event.id);

          emit(state.copyWith(rateStatus: ApiResultStatus.success));
        } on ApiException catch (e) {
          emit(state.copyWith(rateStatus: ApiResultStatus.error, error: e));
        }
      },
    );

    on<FavoriteToggled>((event, emit) => emit(state.copyWith(accountState: state.accountState?.copyWith(favorite: !state.accountState!.favorite))));
  }
}
