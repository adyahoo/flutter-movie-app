import 'package:movie_app/app/data/services/home_service.dart';

import '../models/base_model.dart';
import '../models/movie_model.dart';

class HomeRepository {
  const HomeRepository(this._homeService);

  final HomeService _homeService;

  Future<ListApiResponse<MovieModel>> getPopularMovie() async {
    try{
      final res = await _homeService.getPopularMovie();

      return res;
    }catch (e){
      rethrow;
    }
  }

  Future<ListApiResponse<MovieModel>> getNowPlayingMovie() async {
    try{
      final res = await _homeService.getNowPlayingMovie();

      return res;
    }catch (e){
      rethrow;
    }
  }

  Future<ListApiResponse<MovieModel>> getTopRatedMovie() async {
    try{
      final res = await _homeService.getTopRatedMovie();

      return res;
    }catch (e){
      rethrow;
    }
  }

  Future<ListApiResponse<MovieModel>> getUpcomingMovie() async {
    try{
      final res = await _homeService.getUpcomingMovie();

      return res;
    }catch (e){
      rethrow;
    }
  }
}