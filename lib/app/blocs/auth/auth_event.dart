part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

class LoginAsGuestEvent extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {
  const AuthenticatedEvent({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}

class LogoutEvent extends AuthEvent {}