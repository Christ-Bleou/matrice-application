import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight DatabaseService tailored for the matrix calculator app.
/// It focuses on simple key/value settings and keeps the schema minimal.
class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  Future<void> saveSetting(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveJson(String key, Object value) async {
    final encoded = jsonEncode(value);
    await saveSetting(key, encoded);
  }

  Future<T?> getJson<T>(String key, T Function(Object?) fromJson) async {
    final raw = await getSetting(key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw);
    return fromJson(decoded);
  }
}
