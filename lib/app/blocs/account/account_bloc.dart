import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/data/models/account_model.dart';
import 'package:movie_app/utils/exception/api_exception.dart';
import 'package:movie_app/utils/utilities.dart';

import '../../data/repositories/account_repository.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({required this.accountRepository}) : super(AccountState.initial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(state.copyWith(profile: const ApiResultStates(status: ApiResultStatus.loading)));

      try {
        final res = await accountRepository.getProfile();

        emit(state.copyWith(profile: ApiResultStates(status: ApiResultStatus.success, data: res)));
      } on ApiException catch (e) {
        emit(state.copyWith(profile: ApiResultStates(status: ApiResultStatus.error, error: e)));
        errorHandler(e);
      }
    });
  }
}
