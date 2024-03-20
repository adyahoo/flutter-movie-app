import 'package:movie_app/app/data/services/movie_service.dart';

import '../models/movie_model.dart';

class MovieRepository {
  const MovieRepository(this._movieService);

  final MovieService _movieService;

  Future<MovieTrailerModel> getMovieTrailer(int id) async {
    try {
      final res = await _movieService.getMovieTrailer(id);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieImagesModel> getMovieImages(int id) async {
    try {
      final res = await _movieService.getMovieImages(id);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetailModel> getMovieDetail(int id) async {
    try {
      final res = await _movieService.getMovieDetail(id);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieCreditModel> getMovieCredit(int id) async {
    try {
      final res = await _movieService.getMovieCredit(id);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
