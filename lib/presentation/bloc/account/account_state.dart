part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({
    required this.profile,
    this.favoriteStatus = ApiResultStatus.init,
    this.error,
  });

  final ApiResultStates<AccountModel> profile;
  final ApiResultStatus favoriteStatus;
  final ApiException? error;

  factory AccountState.initial() => const AccountState(profile: ApiResultStates(status: ApiResultStatus.init));

  AccountState copyWith({
    ApiResultStates<AccountModel>? profile,
    ApiResultStatus? favoriteStatus,
    ApiException? error,
  }) {
    return AccountState(
      profile: profile ?? this.profile,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [profile, favoriteStatus, error];
}
