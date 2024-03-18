part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({
    required this.profile,
  });

  final ApiResultStates profile;

  factory AccountState.initial() => const AccountState(profile: ApiResultStates(status: ApiResultStatus.init));

  AccountState copyWith({
    ApiResultStates? profile,
  }) {
    return AccountState(
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [profile];
}
