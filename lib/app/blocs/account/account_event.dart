part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends AccountEvent {}

class FavoriteMovieAdded extends AccountEvent {
  const FavoriteMovieAdded({required this.body});

  final AddFavoriteModel body;

  @override
  List<Object> get props => [body];
}
