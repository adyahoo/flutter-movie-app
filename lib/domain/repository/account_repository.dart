part of 'repository.dart';

class AccountRepository {
  const AccountRepository(this.accountService);

  final AccountService accountService;

  Future<AccountModel> getProfile() async {
    try {
      final res = await accountService.getProfile();

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ListApiResponse<MovieModel>> getRatedMovie() async {
    try {
      final res = await accountService.getRatedMovie();

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ListApiResponse<MovieModel>> getFavoriteMovie() async {
    try {
      final res = await accountService.getFavoriteMovie();

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> addFavorite(AddFavoriteModel body) async {
    try {
      final res = await accountService.addFavorite(body);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ListApiResponse<MovieListModel>> getMyList() async {
    try {
      final res = await accountService.getMyList();

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
