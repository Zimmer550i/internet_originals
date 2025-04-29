import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static Future<void> set(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value.toString());
  }

  static Future<String?> get(String key, {String Function()? onNull}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    return value ?? (onNull != null ? onNull() : null);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
