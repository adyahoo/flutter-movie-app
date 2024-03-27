part of 'list_bloc.dart';

class ListState extends Equatable {
  const ListState({required this.status, this.submitStatus = ApiResultStatus.init, this.movieList, this.error});

  final ApiResultStatus status;
  final ApiResultStatus submitStatus;
  final ApiException? error;
  final List<MovieListModel>? movieList;

  factory ListState.initial() => const ListState(status: ApiResultStatus.init);

  ListState copyWith({
    ApiResultStatus? status,
    ApiResultStatus? submitStatus,
    ApiException? error,
    List<MovieListModel>? movieList,
  }) {
    return ListState(
      status: status ?? this.status,
      submitStatus: submitStatus ?? this.submitStatus,
      error: error ?? this.error,
      movieList: movieList ?? this.movieList,
    );
  }

  @override
  List<Object?> get props => [status, submitStatus, error, movieList];
}
