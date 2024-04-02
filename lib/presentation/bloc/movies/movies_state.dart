part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  const MoviesState({
    required this.status,
    this.error,
    this.movies,
    this.currentPage = 0,
    this.totalPage = 1,
    this.isLoadMore = false,
  });

  final ApiResultStatus status;
  final ApiException? error;
  final List<MovieModel>? movies;
  final int currentPage;
  final int totalPage;
  final bool isLoadMore;

  factory MoviesState.inital() => const MoviesState(status: ApiResultStatus.init);

  MoviesState copyWith({
    ApiResultStatus? status,
    ApiException? error,
    List<MovieModel>? movies,
    int? currentPage,
    int? totalPage,
    bool? isLoadMore,
  }) {
    return MoviesState(
      status: status ?? this.status,
      error: error ?? this.error,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [status, error, movies, currentPage, totalPage, isLoadMore];
}
