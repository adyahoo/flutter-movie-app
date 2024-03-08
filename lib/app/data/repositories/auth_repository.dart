import 'package:movie_app/app/data/models/auth_model.dart';
import 'package:movie_app/app/data/services/auth_service.dart';
import 'package:movie_app/app/data/services/storage_service.dart';

class AuthRepository {
  const AuthRepository({required this.authService, required this.storageService});

  final AuthService authService;
  final StorageService storageService;

  Future<void> login(LoginData loginData) async {
    try {
      final reqTokenRes = await authService.getRequestToken();
      final loginRes = await authService.login(loginData, reqTokenRes.requestToken);
      final createSessionRes = await authService.createSession(loginRes.requestToken);

      storageService.setSessionID(createSessionRes.sessionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginAsGuest() async {
    try {
      final res = await authService.getGuestSession();

      storageService.setIsGuest(true);
      storageService.setSessionID(res.guestSessionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final sessionId = storageService.getSessionID();
      final res = await authService.logout(sessionId!);

      if (res) {
        storageService.setIsGuest(false);
        storageService.setSessionID("");
      }
    } catch (e) {
      rethrow;
    }
  }
}
