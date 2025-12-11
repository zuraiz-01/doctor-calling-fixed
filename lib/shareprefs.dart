import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ====================== TOKEN ======================

  // SAVE TOKEN
  static Future saveToken(String token) async {
    await _prefs?.setString("token", token);
  }

  // GET TOKEN
  static String getToken() {
    return _prefs?.getString("token") ?? "";
  }

  // CLEAR TOKEN
  static Future clearToken() async {
    await _prefs?.remove("token");
  }

  // ====================== LANGUAGE ======================

  // SAVE LANGUAGE
  static Future saveLanguage(String lang) async {
    await _prefs?.setString("language", lang);
  }

  // GET LANGUAGE
  static String getLanguage() {
    return _prefs?.getString("language") ?? "en";
  }
}
