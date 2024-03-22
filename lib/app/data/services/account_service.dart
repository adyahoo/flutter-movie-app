import 'package:dio/dio.dart';
import 'package:movie_app/app/data/client/client.dart';
import 'package:movie_app/app/data/models/account_model.dart';

import '../models/api_model.dart';
import '../models/base_model.dart';

class AccountService {
  const AccountService(this.client);

  final Dio client;

  Future<AccountModel> getProfile() async {
    return clientExecutor<AccountModel>(
      execute: () async {
        final res = await client.get("account");

        return AccountModel.fromJson(res.data);
      },
    );
  }

  Future<ListApiResponse<RatedMovieModel>> getRatedMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("account/account_id/rated/movies");

        return ListApiResponse.fromJson(res.data, (json) => json.map((e) => RatedMovieModel.fromJson(e)).toList());
      },
    );
  }

  Future<ListApiResponse<RatedMovieModel>> getFavoriteMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("account/account_id/favorite/movies");

        return ListApiResponse.fromJson(res.data, (json) => json.map((e) => RatedMovieModel.fromJson(e)).toList());
      },
    );
  }

  Future<ApiResponse> addFavorite(AddFavoriteModel body) async {
    return clientExecutor(
      execute: () async {
        final res = await client.post("account/account_id/favorite", data: body.toJson());

        return ApiResponse.fromJson(res.data);
      },
    );
  }
}
