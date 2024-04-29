part of 'service.dart';

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

  Future<ListApiResponse<MovieModel>> getRatedMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("account/account_id/rated/movies");

        return ListApiResponse.fromJson(res.data, (json) => json.map((e) => MovieModel.fromJson(e)).toList());
      },
    );
  }

  Future<ListApiResponse<MovieModel>> getFavoriteMovie() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("account/account_id/favorite/movies");

        return ListApiResponse.fromJson(res.data, (json) => json.map((e) => MovieModel.fromJson(e)).toList());
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

  Future<ListApiResponse<MovieListModel>> getMyList() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("account/account_id/lists");

        return ListApiResponse.fromJson(res.data, (json) => json.map((e) => MovieListModel.fromJson(e)).toList());
      },
    );
  }
}
