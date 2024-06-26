import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/data/repositories/auth_repository.dart';
import 'package:movie_app/app/data/services/storage_service.dart';
import 'package:movie_app/utils/exception/api_exception.dart';
import 'package:movie_app/utils/utilities.dart';

import '../../data/models/auth_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, ApiResultState> {
  final AuthRepository authRepository;
  final StorageService storageService;

  AuthBloc({required this.authRepository, required this.storageService}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(Loading<Authenticated>());
      final loginData = LoginData(username: event.username, password: event.password);

      try {
        await authRepository.login(loginData);

        emit(Success<Authenticated>(null));
      } on ApiException catch (e) {
        emit(Error<Authenticated>(e));
        errorHandler(e);
      }
    });

    on<LoginAsGuestEvent>((event, emit) async {
      emit(Loading<AuthenticatedAsGuest>());

      try {
        await authRepository.loginAsGuest();

        emit(Success<AuthenticatedAsGuest>(null));
      } on ApiException catch (e) {
        emit(Error<AuthenticatedAsGuest>(e));
        errorHandler(e);
      }
    });

    on<AuthenticatedEvent>((event, emit) async {
      storageService.setSessionID(event.token);
      emit(Success<Authenticated>(null));
    });

    on<LogoutEvent>((event, emit) async {
      emit(Loading<Unauthenticated>());

      try {
        await authRepository.logout();

        emit(Success<Unauthenticated>(null));
      } on ApiException catch (e) {
        emit(Error<Unauthenticated>(e));
        errorHandler(e);
      }
    });

    on<UnauthenticatedEvent>((event, emit) {
      emit(Success<Unauthenticated>(null));
    });
  }
}
