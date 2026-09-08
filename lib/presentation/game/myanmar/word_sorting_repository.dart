// Path: myanmar/word_sorting_repository.dart
import 'dart:math';

import '../english/word_sorting_repository.dart';
import '../model/word_question.dart';

/// Data source for the Myanmar Word Sorting Game.
///
/// Extends [WordSortingRepository] (english/word_sorting_repository.dart)
/// purely so it can be plugged into the shared [WordSortGameController],
/// whose `repository` field is typed to it — the mock data and shape are
/// otherwise unrelated. Stands in for a real
/// `GET /api/v1/games/word-sorting?limit=&language=my` call. Swap the body
/// of [fetchQuestions] for a `dio` call once the backend exists; nothing
/// else in the game needs to change since callers only depend on
/// [WordQuestion].
class MyanmarWordSortingRepository extends WordSortingRepository {
  const MyanmarWordSortingRepository();

  static const List<Map<String, dynamic>> _mockResponse = [
    {
      'id': 'my_word_001',
      'word': 'ခွေး',
      'image_url': 'https://picsum.photos/seed/word-game-my-dog/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/dog.mp3',
    },
    {
      'id': 'my_word_002',
      'word': 'ကြောင်',
      'image_url': 'https://picsum.photos/seed/word-game-my-cat/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/cat.mp3',
    },
    {
      'id': 'my_word_003',
      'word': 'ဆိတ်',
      'image_url': 'https://picsum.photos/seed/word-game-my-goat/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/goat.mp3',
    },
    {
      'id': 'my_word_004',
      'word': 'ကြက်',
      'image_url': 'https://picsum.photos/seed/word-game-my-chicken/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/chicken.mp3',
    },
    {
      'id': 'my_word_005',
      'word': 'ဝက်',
      'image_url': 'https://picsum.photos/seed/word-game-my-pig/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/pig.mp3',
    },
    {
      'id': 'my_word_006',
      'word': 'ငါး',
      'image_url': 'https://picsum.photos/seed/word-game-my-fish/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/fish.mp3',
    },
    {
      'id': 'my_word_007',
      'word': 'ဘဲ',
      'image_url': 'https://picsum.photos/seed/word-game-my-duck/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/duck.mp3',
    },
    {
      'id': 'my_word_008',
      'word': 'ဆင်',
      'image_url': 'https://picsum.photos/seed/word-game-my-elephant/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/elephant.mp3',
    },
    {
      'id': 'my_word_009',
      'word': 'မြင်း',
      'image_url': 'https://picsum.photos/seed/word-game-my-horse/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/horse.mp3',
    },
    {
      'id': 'my_word_010',
      'word': 'ကျား',
      'image_url': 'https://picsum.photos/seed/word-game-my-tiger/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/tiger.mp3',
    },
    {
      'id': 'my_word_011',
      'word': 'ပျား',
      'image_url': 'https://picsum.photos/seed/word-game-my-bee/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/bee.mp3',
    },
    {
      'id': 'my_word_012',
      'word': 'ငှက်',
      'image_url': 'https://picsum.photos/seed/word-game-my-bird/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/my/bird.mp3',
    },
  ];

  @override
  Future<List<WordQuestion>> fetchQuestions({int limit = 10, String language = 'my'}) async {
    // Simulated network latency so loading state is exercised like a real call.
    await Future.delayed(const Duration(milliseconds: 400));

    final pool = List<Map<String, dynamic>>.from(_mockResponse)..shuffle(Random());
    final page = pool.take(limit).toList();
    return WordQuestion.listFromJson(page);
  }
}
