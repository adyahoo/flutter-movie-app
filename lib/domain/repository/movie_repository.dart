part of 'repository.dart';

class MovieRepository {
  const MovieRepository(this._movieService);

  final MovieService _movieService;

  Future<ListApiResponse<MovieModel>> getAllMovies() async {
    try {
      final res = await _movieService.getAllMovies();

      return res;
    } catch (e) {
      rethrow;
    }
  }

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

  Future<ApiResponse> addRating(int id, double rating) async {
    try {
      final res = await _movieService.addRating(id, rating);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> deleteRating(int id) async {
    try {
      final res = await _movieService.deleteRating(id);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<AccountStatesModel> getAccountStates(int id) async {
    try {
      final res = await _movieService.getAccountStates(id);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
