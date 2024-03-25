part of 'service.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  final String SESSION_ID = "session_id";
  final String IS_GUEST = "is_guest";

  static Future<StorageService?> instance() async {
    _instance ??= StorageService();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  bool isLogin() {
    return getSessionID() != null && getSessionID() != "";
  }

  bool isGuest() {
    return getIsGuest() ?? false;
  }

  void setSessionID(String sessionId) async {
    await _preferences!.setString(SESSION_ID, sessionId);
  }

  String? getSessionID() {
    return _preferences!.getString(SESSION_ID);
  }

  void setIsGuest(bool isGuest) async {
    await _preferences!.setBool(IS_GUEST, isGuest);
  }

  bool? getIsGuest() {
    return _preferences!.getBool(IS_GUEST);
  }
}
