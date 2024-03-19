part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({
    required this.profile,
  });

  final ApiResultStates<AccountModel> profile;

  factory AccountState.initial() => const AccountState(profile: ApiResultStates(status: ApiResultStatus.init));

  AccountState copyWith({
    ApiResultStates<AccountModel>? profile,
  }) {
    return AccountState(
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [profile];
}
