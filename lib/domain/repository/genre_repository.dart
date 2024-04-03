import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/data/services/service.dart';

class GenreRepository {
  const GenreRepository(this._genreService);

  final GenreService _genreService;

  Future<List<GenreModel>> getMovieGenres() async {
    try {
      final res = await _genreService.getMovieGenres();

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
