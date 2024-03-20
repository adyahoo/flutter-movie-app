import 'package:dio/dio.dart';
import 'package:movie_app/app/data/client/client.dart';

import '../models/movie_model.dart';

class MovieService {
  const MovieService(this.client);

  final Dio client;

  Future<MovieTrailerModel> getMovieTrailer(int id) async {
    return clientExecutor(execute: () async {
      final res = await client.get("movie/$id/videos");
      List<MovieTrailerModel> listVideos = (res.data['results'] as Iterable).map((e) => MovieTrailerModel.fromJson(e)).toList();

      return listVideos.where((e) => e.type == "Trailer").first;
    });
  }

  Future<MovieImagesModel> getMovieImages(int id) async {
    return clientExecutor(execute: () async {
      final res = await client.get("movie/$id/images");

      return MovieImagesModel.fromJson(res.data);
    });
  }

  Future<MovieDetailModel> getMovieDetail(int id) async {
    return clientExecutor(execute: () async {
      final res = await client.get("movie/$id");

      return MovieDetailModel.fromJson(res.data);
    });
  }

  Future<MovieCreditModel> getMovieCredit(int id) async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("movie/$id/credits");

        return MovieCreditModel.fromJson(res.data);
      }
    );
  }
}
