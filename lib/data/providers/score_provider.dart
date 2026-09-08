// Path: providers/score_provider.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/game_category.dart';

/// Tracks a personal-best score per game title, and exposes one score per
/// [GameCategory] computed as the sum of that category's per-game bests.
/// Category totals are derived rather than stored separately, so they can
/// never drift out of sync with the per-game data.
///
/// Scores are stored in the platform cache directory (not SharedPreferences)
/// so that clearing the app's cache also clears scores, while a normal
/// app restart/force-close does not. Web has no OS-level "clear cache" and
/// no real filesystem, so it falls back to SharedPreferences there.
class ScoreProvider extends ChangeNotifier {
  ScoreProvider({Future<Directory> Function()? directoryProvider})
      : _directoryProvider = directoryProvider ?? getTemporaryDirectory;

  final Future<Directory> Function() _directoryProvider;

  static const String _fileName = 'game_high_scores.json';
  static const String _webStorageKey = 'game_high_scores';
  static const String _webWeekKeyStorageKey = 'game_high_scores_week_key';

  final Map<GameCategory, Map<String, int>> _gameHighScores = {
    for (final category in GameCategory.values) category: {},
  };

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  String? _weekKey;

  /// Scores are grouped into 7-day windows measured from the 1st of the
  /// current month (days 1-7 = week 1, 8-14 = week 2, ... up to a short
  /// final window), not calendar (Mon-Sun) weeks. Crossing into a new
  /// window wipes the previous window's scores.
  String _weekKeyFor(DateTime date) {
    final weekOfMonth = ((date.day - 1) ~/ 7) + 1;
    return '${date.year}-${date.month}-$weekOfMonth';
  }

  int categoryScoreSum(GameCategory category) {
    final scores = _gameHighScores[category]!.values;
    return scores.isEmpty ? 0 : scores.reduce((a, b) => a + b);
  }

  int get englishScoreSum => categoryScoreSum(GameCategory.english);
  int get myanmarScoreSum => categoryScoreSum(GameCategory.myanmar);
  int get mathScoreSum => categoryScoreSum(GameCategory.math);

  int gameHighScore(GameCategory category, String gameTitle) => _gameHighScores[category]![gameTitle] ?? 0;

  Future<File> _scoreFile() async {
    final dir = await _directoryProvider();
    return File('${dir.path}/$_fileName');
  }

  Future<void> load() async {
    _weekKey = _weekKeyFor(DateTime.now());

    if (kIsWeb) {
      await _loadFromPrefs();
    } else {
      await _loadFromCacheFile();
    }

    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _loadFromCacheFile() async {
    final file = await _scoreFile();
    if (!await file.exists()) return;

    final raw = await file.readAsString();
    if (raw.isEmpty) return;

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final storedWeekKey = decoded['weekKey'] as String?;
    if (storedWeekKey != null && storedWeekKey != _weekKey) {
      // A new 7-day window has started; last window's scores no longer apply.
      return;
    }

    final scores = (decoded['scores'] as Map<String, dynamic>?) ?? {};
    for (final entry in scores.entries) {
      final category = GameCategory.values.byName(entry.key);
      final games = (entry.value as Map<String, dynamic>).map(
        (title, score) => MapEntry(title, score as int),
      );
      _gameHighScores[category] = games;
    }
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final storedWeekKey = prefs.getString(_webWeekKeyStorageKey);
    if (storedWeekKey != null && storedWeekKey != _weekKey) {
      await prefs.remove(_webStorageKey);
    }
    await prefs.setString(_webWeekKeyStorageKey, _weekKey!);

    final raw = prefs.getString(_webStorageKey);
    if (raw != null) {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      for (final entry in decoded.entries) {
        final category = GameCategory.values.byName(entry.key);
        final games = (entry.value as Map<String, dynamic>).map(
          (title, score) => MapEntry(title, score as int),
        );
        _gameHighScores[category] = games;
      }
    }
  }

  /// Overwrites the game title's stored score only if [score] beats its
  /// previous best; otherwise leaves everything untouched, per spec.
  Future<void> recordScore({
    required GameCategory category,
    required String gameTitle,
    required int score,
  }) async {
    print("Record-->? $category, $gameTitle, $score");
    final previousBest = gameHighScore(category, gameTitle);
    if (score <= previousBest) return;
    print("Recording new high score for $category/$gameTitle: $score (previous best: $previousBest)");

    _gameHighScores[category]![gameTitle] = score;
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final weekKey = _weekKey ?? _weekKeyFor(DateTime.now());

    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode({
        for (final entry in _gameHighScores.entries) entry.key.name: entry.value,
      });
      await prefs.setString(_webStorageKey, encoded);
      await prefs.setString(_webWeekKeyStorageKey, weekKey);
      return;
    }

    final file = await _scoreFile();
    final encoded = jsonEncode({
      'weekKey': weekKey,
      'scores': {for (final entry in _gameHighScores.entries) entry.key.name: entry.value},
    });
    await file.writeAsString(encoded);
  }

  Future<void> clearScores() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_webStorageKey);
    } else {
      final file = await _scoreFile();
      if (await file.exists()) await file.delete();
    }
    for (final category in GameCategory.values) {
      _gameHighScores[category]!.clear();
    }
    notifyListeners();
  }
}
