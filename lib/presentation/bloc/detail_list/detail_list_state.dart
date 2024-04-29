part of 'detail_list_bloc.dart';

class DetailListState extends Equatable {
  const DetailListState({
    required this.status,
    required this.overlayLoadingStatus,
    required this.accountStateStatus,
    this.error,
    this.data,
    this.accountState,
  });

  final ApiResultStatus status;
  final ApiResultStatus overlayLoadingStatus;
  final ApiResultStatus accountStateStatus;
  final ApiException? error;
  final ListDetailModel? data;
  final AccountStatesModel? accountState;

  factory DetailListState.initial() => const DetailListState(status: ApiResultStatus.init, overlayLoadingStatus: ApiResultStatus.init, accountStateStatus: ApiResultStatus.init);

  DetailListState copyWith({
    ApiResultStatus? status,
    ApiResultStatus? clearStatus,
    ApiResultStatus? rateStatus,
    ApiException? error,
    ListDetailModel? data,
    AccountStatesModel? accountState,
  }) {
    return DetailListState(
      status: status ?? ApiResultStatus.init,
      overlayLoadingStatus: clearStatus ?? ApiResultStatus.init,
      accountStateStatus: rateStatus ?? ApiResultStatus.init,
      error: error ?? this.error,
      data: data ?? this.data,
      accountState: accountState ?? this.accountState,
    );
  }

  @override
  List<Object?> get props => [
        status,
        overlayLoadingStatus,
        accountStateStatus,
        error,
        data,
        accountState,
      ];
}
