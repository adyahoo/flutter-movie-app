import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/config/exception/api_exception.dart';
import 'package:movie_app/data/model/account_model.dart';
import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/data/model/my_list_model.dart';
import 'package:movie_app/domain/repository/repository.dart';
import 'package:movie_app/presentation/bloc/api_result_state.dart';
import 'package:movie_app/utils/utilities.dart';

part 'detail_list_event.dart';

part 'detail_list_state.dart';

class DetailListBloc extends Bloc<DetailListEvent, DetailListState> {
  final MovieRepository movieRepository;
  final AccountRepository accountRepository;
  final ListRepository listRepository;

  DetailListBloc({required this.listRepository, required this.accountRepository, required this.movieRepository}) : super(DetailListState.initial()) {
    on<DetailListFetched>((event, emit) async {
      emit(state.copyWith(status: ApiResultStatus.loading));

      try {
        final res = await listRepository.getListDetail(event.id);

        emit(state.copyWith(status: ApiResultStatus.success, data: res));
      } on ApiException catch (e) {
        errorHandler(e);
        emit(state.copyWith(status: ApiResultStatus.error, error: e));
      }
    });

    on<DetailListCleared>((event, emit) async {
      emit(state.copyWith(clearStatus: ApiResultStatus.loading));

      try {
        await listRepository.clearList(event.id);

        emit(state.copyWith(clearStatus: ApiResultStatus.success));
      } on ApiException catch (e) {
        errorHandler(e);
        emit(state.copyWith(clearStatus: ApiResultStatus.error, error: e));
      }
    });

    on<AccountStateFetched>((event, emit) async {
      emit(state.copyWith(rateStatus: ApiResultStatus.loading));

      try {
        final res = await movieRepository.getAccountStates(event.movieId);

        emit(state.copyWith(rateStatus: ApiResultStatus.success, accountState: res));
      } on ApiException catch (e) {
        errorHandler(e);
        emit(state.copyWith(rateStatus: ApiResultStatus.error, error: e));
      }
    });

    on<RatingAdded>((event, emit) async {
      emit(state.copyWith(clearStatus: ApiResultStatus.loading));

      try {
        await movieRepository.addRating(event.movieId, event.rate);

        emit(state.copyWith(clearStatus: ApiResultStatus.success));
      } on ApiException catch (e) {
        errorHandler(e);
        emit(state.copyWith(clearStatus: ApiResultStatus.error, error: e));
      }
    });

    on<RatingDeleted>((event, emit) async {
      emit(state.copyWith(clearStatus: ApiResultStatus.loading));

      try {
        await movieRepository.deleteRating(event.movieId);

        emit(state.copyWith(clearStatus: ApiResultStatus.success));
      } on ApiException catch (e) {
        errorHandler(e);
        emit(state.copyWith(clearStatus: ApiResultStatus.error, error: e));
      }
    });

    on<MovieFavorited>((event, emit) async {
      emit(state.copyWith(clearStatus: ApiResultStatus.loading));

      try {
        final body = AddFavoriteModel(movieId: event.id, isFavorite: event.isFavorite);
        await accountRepository.addFavorite(body);

        emit(state.copyWith(clearStatus: ApiResultStatus.success));
      } on ApiException catch (e) {
        errorHandler(e);
        emit(state.copyWith(clearStatus: ApiResultStatus.error, error: e));
      }
    });
  }
}
