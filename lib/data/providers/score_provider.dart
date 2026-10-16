// Path: providers/score_provider.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/game_category.dart';

/// Tracks a personal-best score per game title, and exposes one score per
/// [GameCategory] computed as the sum of that category's per-game bests.
/// Category totals are derived rather than stored separately, so they can
/// never drift out of sync with the per-game data.
///
/// Scores live in SharedPreferences (survive app restarts and clearing from
/// recents) and are scoped to the calendar month (Jan, Feb, ...): the first
/// load in a new month wipes the previous month's scores.
class ScoreProvider extends ChangeNotifier {
  static const String _storageKey = 'game_high_scores';
  static const String _monthStorageKey = 'game_high_scores_month';

  final Map<GameCategory, Map<GameTitle, int>> _gameHighScores = {
    for (final category in GameCategory.values) category: {},
  };

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  static String _currentMonthKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}';
  }

  int categoryScoreSum(GameCategory category) {
    final scores = _gameHighScores[category]!.values;
    return scores.isEmpty ? 0 : scores.reduce((a, b) => a + b);
  }

  int get englishScoreSum => categoryScoreSum(GameCategory.english);
  int get myanmarScoreSum => categoryScoreSum(GameCategory.myanmar);
  int get mathScoreSum => categoryScoreSum(GameCategory.math);

  int gameHighScore(GameCategory category, GameTitle gameTitle) => _gameHighScores[category]![gameTitle] ?? 0;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final month = _currentMonthKey();
    if (prefs.getString(_monthStorageKey) != month) {
      // New calendar month (or first run): last month's scores no longer apply.
      await prefs.remove(_storageKey);
      await prefs.setString(_monthStorageKey, month);
    }

    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      for (final entry in decoded.entries) {
        final category = GameCategory.values.byName(entry.key);
        _gameHighScores[category] = _decodeGames(entry.value as Map<String, dynamic>);
      }
    }

    _isLoaded = true;
    notifyListeners();
  }

  /// Stored keys are enum names; unknown (renamed/removed) titles are dropped.
  Map<GameTitle, int> _decodeGames(Map<String, dynamic> raw) {
    final byName = GameTitle.values.asNameMap();
    return {
      for (final e in raw.entries)
        if (byName[e.key] != null) byName[e.key]!: e.value as int,
    };
  }

  Map<String, Map<String, int>> _encodeScores() => {
        for (final c in _gameHighScores.entries)
          c.key.name: {for (final g in c.value.entries) g.key.name: g.value},
      };

  /// Overwrites the game title's stored score only if [score] beats its
  /// previous best; otherwise leaves everything untouched, per spec.
  Future<void> recordScore({
    required GameCategory category,
    required GameTitle gameTitle,
    required int score,
  }) async {
    final previousBest = gameHighScore(category, gameTitle);
    if (score <= previousBest) return;

    _gameHighScores[category]![gameTitle] = score;
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_encodeScores()));
    await prefs.setString(_monthStorageKey, _currentMonthKey());
  }

  Future<void> clearScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    for (final category in GameCategory.values) {
      _gameHighScores[category]!.clear();
    }
    notifyListeners();
  }
}
