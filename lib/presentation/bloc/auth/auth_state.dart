part of 'auth_bloc.dart';

abstract class AuthState extends ApiResultState {
  AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticatedAsGuest extends AuthState {}

class Unauthenticated extends AuthState {}
