import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Clase encargada de guardar el progreso localmente
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  // ─── KEYS ───────────────────────────────────────────────
  static String _statsKey(String mode) => 'stats_$mode';
  static String _progressKey(String mode) => 'progress_$mode';

  // ─── STATS (victorias, intentos, fallos) ────────────────

  // Consigue las estadisticas del usuario
  Future<Map<String, int>> getStats(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_statsKey(gameMode));
    if (raw == null) return {'wins': 0, 'attempts': 0, 'fails': 0};
    return Map<String, int>.from(json.decode(raw));
  }

  // Suma una victoria
  Future<void> addWin(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = await getStats(gameMode);
    stats['wins'] = (stats['wins'] ?? 0) + 1;
    stats['attempts'] = (stats['attempts'] ?? 0) + 1;
    await prefs.setString(_statsKey(gameMode), json.encode(stats));
  }

  // Suma un fallo
  Future<void> addFail(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = await getStats(gameMode);
    stats['fails'] = (stats['fails'] ?? 0) + 1;
    await prefs.setString(_statsKey(gameMode), json.encode(stats));
  }

  // Suma un intento
  Future<void> addAttempt(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = await getStats(gameMode);
    stats['attempts'] = (stats['attempts'] ?? 0) + 1;
    await prefs.setString(_statsKey(gameMode), json.encode(stats));
  }

  // ─── PROGRESO (vidas + índice) ──────────────────────────

  // Guarda el progreso
  Future<void> saveProgress(String gameMode, int lives, int itemIndex) async {
    final prefs = await SharedPreferences.getInstance();
    final progress = {'lives': lives, 'itemIndex': itemIndex};
    await prefs.setString(_progressKey(gameMode), json.encode(progress));
  }

  // Carga el progreso
  Future<Map<String, int>?> loadProgress(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey(gameMode));
    if (raw == null) return null;
    final data = Map<String, int>.from(json.decode(raw));
    return data;
  }

  // Elimina el progreso
  Future<void> clearProgress(String gameMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey(gameMode));
  }
}
