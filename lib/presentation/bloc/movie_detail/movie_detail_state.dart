part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({required this.status, this.backdrops, this.detail, this.credit, this.accountState, this.error, this.rateStatus});

  final ApiResultStatus status;
  final ApiResultStatus? rateStatus;
  final ApiException? error;
  final List<ImageModel>? backdrops;
  final MovieDetailModel? detail;
  final MovieCreditModel? credit;
  final AccountStatesModel? accountState;

  factory MovieDetailState.initial() => const MovieDetailState(status: ApiResultStatus.init);

  MovieDetailState copyWith({
    ApiResultStatus? status,
    ApiResultStatus? rateStatus,
    ApiException? error,
    List<ImageModel>? backdrops,
    MovieDetailModel? detail,
    MovieCreditModel? credit,
    AccountStatesModel? accountState,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      error: error ?? this.error,
      backdrops: backdrops ?? this.backdrops,
      detail: detail ?? this.detail,
      credit: credit ?? this.credit,
      accountState: accountState ?? this.accountState,
      rateStatus: rateStatus ?? this.rateStatus,
    );
  }

  @override
  List<Object?> get props => [status, error, backdrops, detail, credit, accountState, rateStatus];
}
