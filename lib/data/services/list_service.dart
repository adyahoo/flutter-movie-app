part of 'service.dart';

class ListService {
  const ListService(this.client);

  final Dio client;

  Future<ListApiResponse<MovieListModel>> getList() async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("account/account_id/lists");

        return ListApiResponse.fromJson(res.data, (json) => json.map((e) => MovieListModel.fromJson(e)).toList());
      },
    );
  }

  Future<ApiResponse> addMovie(int listId, int movieId) async {
    return clientExecutor(
      execute: () async {
        final body = {"media_id": movieId};

        final res = await client.post("list/$listId/add_item", data: body);

        return ApiResponse.fromJson(res.data);
      },
    );
  }
}
