import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  final SharedPreferences _prefs;

  Prefs(this._prefs);

  static const _keyName = 'user_name';
  static const _keyEmail = 'user_email';
  static const _keyPhoto = 'user_photo';
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyUserId = 'user_id';
  static const _keyThemeMode = 'theme_mode';
  static const _keyReadingModeDefaultReciter = 'reading_mode_default_reciter';

  Future<void> saveUser({
    required String name,
    required String email,
    required String photo,
    required String userId,
  }) async {
    await _prefs.setString(_keyName, name);
    await _prefs.setString(_keyEmail, email);
    await _prefs.setString(_keyPhoto, photo);
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserId, userId);
  }

  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(_keyThemeMode, themeMode);
  }

  String? get name => _prefs.getString(_keyName);
  String? get email => _prefs.getString(_keyEmail);
  String? get photo => _prefs.getString(_keyPhoto);
  String get themeMode => _prefs.getString(_keyThemeMode) ?? "dark";
  // bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;

  Future<bool> isLoggedIn() async {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  Future<void> saveReadingModeDefaultReciter(int reciterId) async {
    await _prefs.setInt(_keyReadingModeDefaultReciter, reciterId);
  }

  int get readingModeDefaultReciter =>
      _prefs.getInt(_keyReadingModeDefaultReciter) ?? 1;

  String? get userId => _prefs.getString(_keyUserId);
}
