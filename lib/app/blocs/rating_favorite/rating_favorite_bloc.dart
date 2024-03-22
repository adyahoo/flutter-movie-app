import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/data/models/account_model.dart';
import 'package:movie_app/app/data/models/base_model.dart';
import 'package:movie_app/app/data/repositories/account_repository.dart';
import 'package:movie_app/utils/exception/api_exception.dart';

part 'rating_favorite_event.dart';

part 'rating_favorite_state.dart';

class RatingFavoriteBloc extends Bloc<RatingFavoriteEvent, RatingFavoriteState> {
  final AccountRepository accountRepository;

  RatingFavoriteBloc({required this.accountRepository}) : super(RatingFavoriteState.initial()) {
    on<RatedMoviesFetched>((event, emit) async {
      emit(state.copyWith(status: ApiResultStatus.loading));

      try {
        final res = await accountRepository.getRatedMovie();

        emit(state.copyWith(status: ApiResultStatus.success, ratedMovies: res));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ApiResultStatus.error, error: e));
      }
    });
  }
}
