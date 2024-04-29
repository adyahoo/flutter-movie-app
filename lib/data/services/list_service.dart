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

  Future<ListDetailModel> getListDetail(int id) async {
    return clientExecutor(
      execute: () async {
        final res = await client.get("list/$id");

        return ListDetailModel.fromJson(res.data);
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

  Future<ApiResponse> removeMovie(int listId, int movieId) async {
    return clientExecutor(
      execute: () async {
        final body = {"media_id": movieId};

        final res = await client.post("list/$listId/remove_item", data: body);

        return ApiResponse.fromJson(res.data);
      },
    );
  }

  Future<ApiResponse> createList(CreateListModel data) async {
    return clientExecutor(
      execute: () async {
        final res = await client.post("list", data: data.toJson());

        return ApiResponse.fromJson(res.data);
      },
    );
  }

  Future<ApiResponse> deleteList(int id) async {
    return clientExecutor(
      execute: () async {
        final res = await client.delete("list/$id");

        return ApiResponse.fromJson(res.data);
      },
    );
  }

  Future<ApiResponse> clearList(int id) async {
    return clientExecutor(
      execute: () async {
        final res = await client.post("list/$id/clear", queryParameters: {"confirm": true});

        return ApiResponse.fromJson(res.data);
      },
    );
  }
}
