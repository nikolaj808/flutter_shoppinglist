import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKey {
  static String themeMode = 'THEME_MODE';
  static String previousList = 'PREVIOUS_LIST';
}

class SharedPreferencesService {
  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getBool(key);
    } catch (_) {
      return null;
    }
  }

  static Future<void> setBool(String key, {bool value = false}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getString(key);
    } catch (_) {
      return null;
    }
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  static Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
  }
}
