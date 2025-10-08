import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  final SharedPreferences _prefs;

  Prefs(this._prefs);

  static const _keyName = 'user_name';
  static const _keyEmail = 'user_email';
  static const _keyPhoto = 'user_photo';
  static const _keyIsLoggedIn = 'is_logged_in';

  Future<void> saveUser({
    required String name,
    required String email,
    required String photo,
  }) async {
    await _prefs.setString(_keyName, name);
    await _prefs.setString(_keyEmail, email);
    await _prefs.setString(_keyPhoto, photo);
    await _prefs.setBool(_keyIsLoggedIn, true);
  }

  String? get name => _prefs.getString(_keyName);
  String? get email => _prefs.getString(_keyEmail);
  String? get photo => _prefs.getString(_keyPhoto);
  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;

  Future<void> clear() async {
    await _prefs.clear();
  }
}
