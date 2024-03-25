part of 'service.dart';

class HomeService {
  const HomeService(this.client);

  final Dio client;

  Future<ListApiResponse<MovieModel>> getPopularMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("movie/popular");

        return ListApiResponse.fromJson(res.data, (json) => (json).map((e) => MovieModel.fromJson(e)).toList());
      },
    );
  }

  Future<ListApiResponse<MovieModel>> getNowPlayingMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("movie/now_playing");

        return ListApiResponse.fromJson(res.data, (json) => (json).map((e) => MovieModel.fromJson(e)).toList());
      },
    );
  }

  Future<ListApiResponse<MovieModel>> getTopRatedMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("movie/top_rated");

        return ListApiResponse.fromJson(res.data, (json) => (json).map((e) => MovieModel.fromJson(e)).toList());
      },
    );
  }

  Future<ListApiResponse<MovieModel>> getUpcomingMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("movie/upcoming");

        return ListApiResponse.fromJson(res.data, (json) => (json).map((e) => MovieModel.fromJson(e)).toList());
      },
    );
  }
}
