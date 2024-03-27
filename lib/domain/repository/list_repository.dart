part of 'repository.dart';

class ListRepository {
  const ListRepository(this._listService);

  final ListService _listService;

  Future<ListApiResponse<MovieListModel>> getList() async {
    try {
      final res = await _listService.getList();

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> addMovie(int listId, int movieId) async {
    try {
      final res = await _listService.addMovie(listId, movieId);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}