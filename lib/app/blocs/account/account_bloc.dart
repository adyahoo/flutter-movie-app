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

class AccountBloc extends Bloc<AccountEvent, ApiResultState> {
  final AccountRepository accountRepository;

  AccountBloc({required this.accountRepository}) : super(AccountInitial())  {
    on<GetProfileEvent>((event, emit) async {
      emit(Loading<Profile>());

      try{
        final res = await accountRepository.getProfile();

        emit(Success<Profile>(res));
      }on ApiException catch(e){
        emit(Error<Profile>(e));
        errorHandler(e);
      }
    });
  }
}
