part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.popular,
    required this.nowPlaying,
    required this.upcoming,
    required this.topRated,
  });

  final ApiResultStates<List<MovieModel>> popular;
  final ApiResultStates<List<MovieModel>> nowPlaying;
  final ApiResultStates<List<MovieModel>> upcoming;
  final ApiResultStates<List<MovieModel>> topRated;

  factory HomeState.initial() => const HomeState(
        popular: ApiResultStates(status: ApiResultStatus.init),
        nowPlaying: ApiResultStates(status: ApiResultStatus.init),
        upcoming: ApiResultStates(status: ApiResultStatus.init),
        topRated: ApiResultStates(status: ApiResultStatus.init),
      );

  @override
  List<Object?> get props => [popular, nowPlaying, upcoming, topRated];

  HomeState copyWith({
    ApiResultStates<List<MovieModel>>? popular,
    ApiResultStates<List<MovieModel>>? nowPlaying,
    ApiResultStates<List<MovieModel>>? upcoming,
    ApiResultStates<List<MovieModel>>? topRated,
  }) {
    return HomeState(
      popular: popular ?? this.popular,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      upcoming: upcoming ?? this.upcoming,
      topRated: topRated ?? this.topRated,
    );
  }
}
