part of 'account_bloc.dart';

abstract class AccountState extends ApiResultState {
  AccountState();
}

class AccountInitial extends AccountState {}

class Profile extends AccountState {
  Profile(this.data);

  final AccountModel data;

  @override
  List<Object?> get props => [data];
}
