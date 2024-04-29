part of 'list_bloc.dart';

class ListState extends Equatable {
  const ListState({
    required this.status,
    this.detailStatus = ApiResultStatus.init,
    this.submitStatus = ApiResultStatus.init,
    this.deleteStatus = ApiResultStatus.init,
    this.movieList,
    this.detail,
    this.error,
  });

  final ApiResultStatus status;
  final ApiResultStatus detailStatus;
  final ApiResultStatus submitStatus;
  final ApiResultStatus deleteStatus;
  final ApiException? error;
  final List<MovieListModel>? movieList;
  final ListDetailModel? detail;

  factory ListState.initial() => const ListState(status: ApiResultStatus.init);

  ListState copyWith({
    ApiResultStatus? status,
    ApiResultStatus? detailStatus,
    ApiResultStatus? submitStatus,
    ApiResultStatus? deleteStatus,
    ApiException? error,
    List<MovieListModel>? movieList,
    ListDetailModel? detail,
  }) {
    return ListState(
      status: status ?? this.status,
      detailStatus: detailStatus ?? this.detailStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      error: error ?? this.error,
      movieList: movieList ?? this.movieList,
      detail: detail ?? this.detail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        deleteStatus,
        submitStatus,
        deleteStatus,
        error,
        movieList,
        detail,
      ];
}
