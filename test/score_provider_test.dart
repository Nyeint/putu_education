import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:putu_education/data/model/game_category.dart';
import 'package:putu_education/data/providers/score_provider.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('score_provider_test_');
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  ScoreProvider makeProvider() => ScoreProvider(directoryProvider: () async => tempDir);

  test('category score sum starts at 0 with no games played', () async {
    final provider = makeProvider();
    await provider.load();

    expect(provider.mathScoreSum, 0);
    expect(provider.englishScoreSum, 0);
    expect(provider.myanmarScoreSum, 0);
  });

  test('spec example: category total sums every game title\'s personal best', () async {
    final provider = makeProvider();
    await provider.load();

    await provider.recordScore(category: GameCategory.math, gameTitle: 'Counting', score: 80);
    expect(provider.mathScoreSum, 80);

    await provider.recordScore(category: GameCategory.math, gameTitle: 'Calculating', score: 60);
    expect(provider.mathScoreSum, 140);

    await provider.recordScore(category: GameCategory.math, gameTitle: 'Calculating', score: 95);
    expect(provider.gameHighScore(GameCategory.math, 'Calculating'), 95);
    expect(provider.mathScoreSum, 175);
  });

  test('a lower or equal score never overwrites the game title personal best', () async {
    final provider = makeProvider();
    await provider.load();

    await provider.recordScore(category: GameCategory.english, gameTitle: 'Vocabulary', score: 70);
    await provider.recordScore(category: GameCategory.english, gameTitle: 'Vocabulary', score: 70);
    await provider.recordScore(category: GameCategory.english, gameTitle: 'Vocabulary', score: 50);

    expect(provider.gameHighScore(GameCategory.english, 'Vocabulary'), 70);
    expect(provider.englishScoreSum, 70);
  });

  test('categories are independent of each other', () async {
    final provider = makeProvider();
    await provider.load();

    await provider.recordScore(category: GameCategory.math, gameTitle: 'Counting', score: 80);
    await provider.recordScore(category: GameCategory.myanmar, gameTitle: 'Alphabet', score: 40);

    expect(provider.mathScoreSum, 80);
    expect(provider.myanmarScoreSum, 40);
    expect(provider.englishScoreSum, 0);
  });

  test('scores persist across a fresh load from storage (survives app restart)', () async {
    final first = makeProvider();
    await first.load();
    await first.recordScore(category: GameCategory.math, gameTitle: 'Counting', score: 80);
    await first.recordScore(category: GameCategory.math, gameTitle: 'Calculating', score: 95);

    final second = makeProvider();
    await second.load();

    expect(second.mathScoreSum, 175);
    expect(second.gameHighScore(GameCategory.math, 'Counting'), 80);
    expect(second.gameHighScore(GameCategory.math, 'Calculating'), 95);
  });

  test('scores persist when reloaded within the same 7-day window', () async {
    final first = makeProvider();
    await first.load();
    await first.recordScore(category: GameCategory.math, gameTitle: 'Counting', score: 80);

    final second = makeProvider();
    await second.load();

    expect(second.gameHighScore(GameCategory.math, 'Counting'), 80);
  });

  test('scores reset once a new 7-day window (from the 1st of the month) begins', () async {
    final staleFile = File('${tempDir.path}/game_high_scores.json');
    await staleFile.writeAsString(jsonEncode({
      'weekKey': 'stale-week-key',
      'scores': {
        'math': {'Counting': 80},
      },
    }));

    final provider = makeProvider();
    await provider.load();

    expect(provider.gameHighScore(GameCategory.math, 'Counting'), 0);
    expect(provider.mathScoreSum, 0);
  });

  test('clearScores wipes the cache file so a reload starts fresh', () async {
    final provider = makeProvider();
    await provider.load();
    await provider.recordScore(category: GameCategory.math, gameTitle: 'Counting', score: 80);

    await provider.clearScores();
    expect(provider.mathScoreSum, 0);

    final reloaded = makeProvider();
    await reloaded.load();
    expect(reloaded.mathScoreSum, 0);
  });
}
