part of 'service.dart';

class GenreService {
  const GenreService(this.client);

  final Dio client;

  Future<List<GenreModel>> getMovieGenres() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("genre/movie/list");

        return (res.data['genres'] as Iterable).map((e) => GenreModel.fromJson(e)).toList();
      },
    );
  }
}
