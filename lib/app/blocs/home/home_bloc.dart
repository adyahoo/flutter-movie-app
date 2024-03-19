import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/utils/exception/api_exception.dart';
import 'package:movie_app/utils/utilities.dart';

import '../../data/models/movie_model.dart';
import '../../data/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeState.initial()) {
    on<GetPopularEvent>((event, emit) async {
      emit(state.copyWith(popular: const ApiResultStates(status: ApiResultStatus.loading)));

      try {
        final res = await homeRepository.getPopularMovie();

        emit(
          state.copyWith(
            popular: ApiResultStates(
              data: res.results,
              status: ApiResultStatus.success,
            ),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(popular: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });

    on<GetNowPlayingEvent>((event, emit) async {
      emit(state.copyWith(popular: const ApiResultStates(status: ApiResultStatus.loading)));

      try {
        final res = await homeRepository.getNowPlayingMovie();

        emit(
          state.copyWith(
            nowPlaying: ApiResultStates(
              data: res.results,
              status: ApiResultStatus.success,
            ),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(nowPlaying: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });

    on<GetUpcomingEvent>((event, emit) async {
      emit(state.copyWith(upcoming: const ApiResultStates(status: ApiResultStatus.loading)));

      try {
        final res = await homeRepository.getUpcomingMovie();

        emit(
          state.copyWith(
            upcoming: ApiResultStates(status: ApiResultStatus.success, data: res.results),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(upcoming: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });

    on<GetTopRatedEvent>((event, emit) async {
      emit(state.copyWith(topRated: const ApiResultStates(status: ApiResultStatus.loading)));

      try {
        final res = await homeRepository.getTopRatedMovie();

        emit(
          state.copyWith(
            topRated: ApiResultStates(status: ApiResultStatus.success, data: res.results),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(topRated: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });
  }
}
