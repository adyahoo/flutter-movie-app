import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/presentation/bloc/api_result_state.dart';
import 'package:movie_app/data/model/account_model.dart';
import 'package:movie_app/utils/utilities.dart';

import '../../../config/exception/api_exception.dart';
import '../../../domain/repository/repository.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({required this.accountRepository}) : super(AccountState.initial()) {
    on<GetProfileEvent>(
      (event, emit) async {
        emit(state.copyWith(profile: const ApiResultStates(status: ApiResultStatus.loading)));

        try {
          final res = await accountRepository.getProfile();

          emit(state.copyWith(profile: ApiResultStates(status: ApiResultStatus.success, data: res)));
        } on ApiException catch (e) {
          emit(state.copyWith(profile: ApiResultStates(status: ApiResultStatus.error, error: e)));
          errorHandler(e);
        }
      },
    );

    on<FavoriteMovieAdded>(
      (event, emit) async {
        emit(state.copyWith(favoriteStatus: ApiResultStatus.loading));

        try {
          await accountRepository.addFavorite(event.body);

          emit(state.copyWith(favoriteStatus: ApiResultStatus.success));
        } on ApiException catch (e) {
          emit(state.copyWith(favoriteStatus: ApiResultStatus.error, error: e));
        }
      },
    );
  }
}
