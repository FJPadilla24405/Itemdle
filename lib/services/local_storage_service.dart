import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  // ─── KEYS ───────────────────────────────────────────────
  static String _statsKey(String mode) => 'stats_$mode';
  static String _progressKey(String mode) => 'progress_$mode';

  // ─── STATS (victorias, intentos, fallos) ────────────────

  Future<Map<String, int>> getStats(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_statsKey(gameMode));
    if (raw == null) return {'wins': 0, 'attempts': 0, 'fails': 0};
    return Map<String, int>.from(json.decode(raw));
  }

  Future<void> addWin(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = await getStats(gameMode);
    stats['wins'] = (stats['wins'] ?? 0) + 1;
    stats['attempts'] = (stats['attempts'] ?? 0) + 1;
    await prefs.setString(_statsKey(gameMode), json.encode(stats));
    print('✅ Stats guardadas ($gameMode): $stats');
  }

  Future<void> addFail(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = await getStats(gameMode);
    stats['fails'] = (stats['fails'] ?? 0) + 1;
    await prefs.setString(_statsKey(gameMode), json.encode(stats));
    print('❌ Fallo registrado ($gameMode): $stats');
  }

  Future<void> addAttempt(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = await getStats(gameMode);
    stats['attempts'] = (stats['attempts'] ?? 0) + 1;
    await prefs.setString(_statsKey(gameMode), json.encode(stats));
  }

  // ─── PROGRESO (vidas + índice) ──────────────────────────

  Future<void> saveProgress(String gameMode, int lives, int itemIndex) async {
    final prefs = await SharedPreferences.getInstance();
    final progress = {'lives': lives, 'itemIndex': itemIndex};
    await prefs.setString(_progressKey(gameMode), json.encode(progress));
    print('💾 Progreso guardado ($gameMode): vidas=$lives, índice=$itemIndex');
  }

  Future<Map<String, int>?> loadProgress(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey(gameMode));
    if (raw == null) return null;
    final data = Map<String, int>.from(json.decode(raw));
    print('📂 Progreso cargado ($gameMode): $data');
    return data;
  }

  Future<void> clearProgress(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey(gameMode));
    print('🗑️ Progreso eliminado ($gameMode)');
  }
}
